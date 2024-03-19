using Microsoft.AspNetCore.Mvc;
using Keeper.Domen.ModelsPharmacy;
using Keeper.Domen;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.Identity.Client;
using Azure;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Keeper.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PharmacyController : ControllerBase
    {
        public readonly PharmacyDbContext _db;

        public PharmacyController(PharmacyDbContext db)
        {
            _db = db;
        }

        // GET: /Warehouses
        [HttpGet("Warehouses")]
        public async Task<ActionResult<IEnumerable<Warehouse>>> GetWarehouses()
        {
            var response = await _db.Warehouses.ToListAsync();

            if (response != null)
                return Ok(response);

            else
                return BadRequest(response);
        }

        // GET: /IssueRequests
        /// <summary>
        ///Cписок заявок на выдачу лекарственных препаратов для отделений
        /// </summary>
        /// <returns></returns>
        [HttpGet("IssueRequests")]
        public async Task<ActionResult<IEnumerable<Issue>>> GetIssue()
        {
            var response = await _db.Issues.ToListAsync();

            if (response != null)
                return Ok(response);

            else
                return BadRequest(response);
        }

        // GET: /Medicines?WarehouseId=2
        /// <summary>
        /// Cписок лекарственных препаратов и их наличие на складах 
        /// </summary>
        /// <param name="WarehouseId"></param>
        /// <returns></returns>
        [HttpGet("Medicines")]
        public async Task<ActionResult<IEnumerable<Medicine>>> GetMedicines(int WarehouseId = 0)
        {
            List<Medicine> response = new();
            if (WarehouseId == 0)
            {
                response = await _db.Medicines.ToListAsync();
            }
            else
            {
                response = await _db.Medicines.Where(p => p.WarehouseId == WarehouseId).ToListAsync();
            }
           

            if (response != null)
                return Ok(response);

            else
                return BadRequest(response);
        }

        //GET: /Medicines?name="d"
        /// <summary>
        /// Поиск лекарства по названию
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [HttpGet("Medicines/Contain")]
        public async Task<ActionResult<List<Medicine>?>> GetMedicinesById(string name)
        {
            var cont = await _db.Medicines.Where(p => p.Name.Contains(name)).FirstOrDefaultAsync();
            if (cont != null)
            {
                var response = await _db.Medicines.Where(p => p.Name == cont.Name).ToListAsync();
                if (response != null)
                    return Ok(response);

                else
                    return BadRequest(response);
            }
            else return BadRequest(cont);

        }

        // GET: /Medicines/RunningOut
        [HttpGet("Medicines/RunningOut")]
        public async Task<ActionResult<IEnumerable<Medicine>>> GetRunningOut()
        {
            var response = await _db.Medicines.Where(p => p.StockQuantity < p.OptimalQuantity).ToListAsync();

            if (response != null)
                return Ok(response);

            else
                return BadRequest(response);
        }

        //GET: /IssueRequestsItem
        /// <summary>
        /// Подробный просмотр заявки
        /// </summary>
        /// <param name="IssueId"></param>
        /// <returns></returns>
        [HttpGet("IssueRequestsItem/{IssueId}")]
        public async Task<ActionResult<IEnumerable<IssueItem>?>> GetIssue([FromRoute] int IssueId)
        {
            var response = await _db.IssuesItems.Where(p => p.IssueId == IssueId).ToListAsync();

            if (response != null)
                return Ok(response);
            else
                return BadRequest(response);
        }

        //POST: /Medicines/Invoice
        [HttpPost("Medicines/Invoice")]
        public async Task<ActionResult> PostMedicinesInvoice(Invoice invoice)
        {
            var list = invoice.Medicines;

            foreach (var item in list)
            {
                if (item.ExpirationDate < DateTime.Now)//проверка срока годности
                {
                    return BadRequest("Невозможно принять счет, так как в списке встречаются просроченные препараты");
                }

            }

            _db.Invoices.Add(invoice);

            try
            {
                _db.SaveChanges();
                return Ok();
            }
            catch (Exception ex) { return BadRequest(); }
        }

        //POST: /Medicines/Writeoff
        /// <summary>
        /// Cписание лекарственных препаратов с указанием причины по каждой позиции;
        /// </summary>
        /// <param name="writeoff"></param>
        /// <returns></returns>
        [HttpPost("Medicines/Writeoff")]
        public async Task<ActionResult> PostMedicinesWriteoff(MedicinesWriteOff writeoff)
        {
            var medicines = await _db.Medicines.Where(p => p.Id == writeoff.MedicineId).FirstOrDefaultAsync();
            if (writeoff.Quantity < 0)
            {
                return BadRequest("Нет смысла делать списание отрицательного/нулевого количества");
            }
            if (writeoff.Reason == "")
            {
                return BadRequest("Причина обязательна для фиксации факта списания");
            }
            if (medicines == null)
            {
                return NotFound("Медицинский препарат с указанным ID не найден");
            }
            if (medicines.StockQuantity < writeoff.Quantity)
            {
                return BadRequest("На остатке меньшее количество, чем вы пытаетесь списать");
            }

            medicines.StockQuantity -= writeoff.Quantity;

            _db.Medicines.Update(medicines);

            try
            {
                _db.SaveChangesAsync();
            }
            catch (Exception)
            {

                throw;
            }

            return Ok();
        }

        //POST: /Medicines/3/Transfer
        /// <summary>
        /// Перемещение лекарственных препаратов между складами;
        /// </summary>
        /// <param name="MedicinesId"></param>
        /// <param name="destinationWarehouseId"></param>
        /// <returns></returns>
        [HttpPost("Medicines/{MedicinesId}/Transfer")]
        public async Task<ActionResult> PostTransfer([FromRoute] int MedicinesId, int destinationWarehouseId)
        {
            if (await _db.Warehouses.Where(w => w.Id == destinationWarehouseId).FirstOrDefaultAsync() == null)
            {
                return NotFound("Склад назначения с указанным Id не найден");
            }

            var m = await _db.Medicines.FindAsync(MedicinesId);
            if (m.WarehouseId == destinationWarehouseId)
            {
                return BadRequest("Склад назначения совпадает с текущим складом");
            }

            m.WarehouseId = destinationWarehouseId;
            _db.Medicines.Update(m);

            try
            {
                _db.SaveChanges();
            }
            catch (Exception ex)
            {
                return BadRequest();
            }

            return Ok();
        }

        //PUT: /IssueRequests/3/Complete
        /// <summary>
        /// Фиксация отпуска лекарственных препаратов;
        /// </summary>
        /// <param name="IssueId"></param>
        /// <returns></returns>
        [HttpPut("IssueRequests/{IssueId}/Complete")]
        public async Task<ActionResult> PutIssueComplete([FromRoute] int IssueId)
        {
            var issue = await _db.Issues.FindAsync(IssueId);
            if (issue.Status == "Complete")
            {
                return BadRequest("Заявка на выдачу уже выполнена");
            }

            var issueitem = await _db.IssuesItems.Where(i => i.IssueId == IssueId).ToListAsync(); //все лекарства по заявке
            List<Medicine> med = new();

            foreach (var item in issueitem)
            {
                
                if (item.Medicine.StockQuantity < item.Quantity) //проверка на количество
                {
                    return BadRequest($"Невозможно выполнить заявку прямо сейчас, так как не хватает препарата с Id={item.Medicine.Id} " +
                        $"(запрашивается {item.Quantity} шт., а в наличии только {item.Medicine.StockQuantity} шт.)");
                }
                else
                {
                    med.Add(item.Medicine);
                    item.Medicine.StockQuantity -= item.Quantity;
                }
            }
           
            _db.Medicines.UpdateRange(med);
            issue.Status = "Complete";
            try
            {
                _db.SaveChangesAsync();
            }
            catch (Exception)
            {

                throw;
            }

            return Ok();
        }
    }
}

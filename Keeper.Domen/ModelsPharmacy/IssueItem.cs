using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Keeper.Domen.ModelsPharmacy;

public class IssueItem
{
    public int Id { get; set; }
    public int IssueId { get; set; }
    public Issue Issue { get; set; }
    public int Quantity { get; set; }

    public int MedicineId { get; set; }
    public Medicine? Medicine { get; set;}
}

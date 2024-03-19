using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Keeper.Domen.Migrations
{
    /// <inheritdoc />
    public partial class _20 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Issues_Medicines_MedicinesId",
                table: "Issues");

            migrationBuilder.DropIndex(
                name: "IX_Issues_MedicinesId",
                table: "Issues");

            migrationBuilder.DropColumn(
                name: "MedicinesId",
                table: "Issues");

            migrationBuilder.DropColumn(
                name: "Quantity",
                table: "Issues");

            migrationBuilder.CreateTable(
                name: "IssueItem",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IssueId = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    MedicineId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_IssueItem", x => x.Id);
                    table.ForeignKey(
                        name: "FK_IssueItem_Issues_IssueId",
                        column: x => x.IssueId,
                        principalTable: "Issues",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_IssueItem_Medicines_MedicineId",
                        column: x => x.MedicineId,
                        principalTable: "Medicines",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_IssueItem_IssueId",
                table: "IssueItem",
                column: "IssueId");

            migrationBuilder.CreateIndex(
                name: "IX_IssueItem_MedicineId",
                table: "IssueItem",
                column: "MedicineId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "IssueItem");

            migrationBuilder.AddColumn<int>(
                name: "MedicinesId",
                table: "Issues",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Quantity",
                table: "Issues",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Issues_MedicinesId",
                table: "Issues",
                column: "MedicinesId");

            migrationBuilder.AddForeignKey(
                name: "FK_Issues_Medicines_MedicinesId",
                table: "Issues",
                column: "MedicinesId",
                principalTable: "Medicines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

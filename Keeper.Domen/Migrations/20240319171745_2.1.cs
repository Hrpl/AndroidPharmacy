using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Keeper.Domen.Migrations
{
    /// <inheritdoc />
    public partial class _21 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_IssueItem_Issues_IssueId",
                table: "IssueItem");

            migrationBuilder.DropForeignKey(
                name: "FK_IssueItem_Medicines_MedicineId",
                table: "IssueItem");

            migrationBuilder.DropPrimaryKey(
                name: "PK_IssueItem",
                table: "IssueItem");

            migrationBuilder.RenameTable(
                name: "IssueItem",
                newName: "IssuesItems");

            migrationBuilder.RenameIndex(
                name: "IX_IssueItem_MedicineId",
                table: "IssuesItems",
                newName: "IX_IssuesItems_MedicineId");

            migrationBuilder.RenameIndex(
                name: "IX_IssueItem_IssueId",
                table: "IssuesItems",
                newName: "IX_IssuesItems_IssueId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_IssuesItems",
                table: "IssuesItems",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_IssuesItems_Issues_IssueId",
                table: "IssuesItems",
                column: "IssueId",
                principalTable: "Issues",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_IssuesItems_Medicines_MedicineId",
                table: "IssuesItems",
                column: "MedicineId",
                principalTable: "Medicines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_IssuesItems_Issues_IssueId",
                table: "IssuesItems");

            migrationBuilder.DropForeignKey(
                name: "FK_IssuesItems_Medicines_MedicineId",
                table: "IssuesItems");

            migrationBuilder.DropPrimaryKey(
                name: "PK_IssuesItems",
                table: "IssuesItems");

            migrationBuilder.RenameTable(
                name: "IssuesItems",
                newName: "IssueItem");

            migrationBuilder.RenameIndex(
                name: "IX_IssuesItems_MedicineId",
                table: "IssueItem",
                newName: "IX_IssueItem_MedicineId");

            migrationBuilder.RenameIndex(
                name: "IX_IssuesItems_IssueId",
                table: "IssueItem",
                newName: "IX_IssueItem_IssueId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_IssueItem",
                table: "IssueItem",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_IssueItem_Issues_IssueId",
                table: "IssueItem",
                column: "IssueId",
                principalTable: "Issues",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_IssueItem_Medicines_MedicineId",
                table: "IssueItem",
                column: "MedicineId",
                principalTable: "Medicines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

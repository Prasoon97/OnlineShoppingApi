using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OnlineShoppingApi.Migrations
{
    public partial class AddedMinOrderAndMaxOrderInProduct : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "MaxOrder",
                table: "Products",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MinOrder",
                table: "Products",
                type: "int",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MaxOrder",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "MinOrder",
                table: "Products");
        }
    }
}

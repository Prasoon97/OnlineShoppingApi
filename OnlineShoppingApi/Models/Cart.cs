using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Swashbuckle.AspNetCore.Annotations;

namespace OnlineShoppingApi.Models
{
    public class Cart
    {
        [Key]
        public int CartId { get; set; }
        [JsonIgnore]
        //[ForeignKey("UserDetail")]
        public string? UserId { get; set; }
        [ForeignKey("ProductDetail")]
        public int ProductId { get; set; }
        [Required]
        public int Quantity { get; set; }
        [ForeignKey("OrderDetail")]
        public int? OrderId { get; set; }
        [JsonIgnore]
        public Order? OrderDetail { get; set; }
        // [JsonIgnore]
        // public User? UserDetail { get; set; }
       
        public Product? ProductDetail { get; set; }
    }
}
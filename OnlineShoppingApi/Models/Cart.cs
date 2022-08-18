using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

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
        [Range(1, int.MaxValue, ErrorMessage = "Quantity should be {1} or greater")]
        public int Quantity { get; set; }
        [ForeignKey("OrderDetail")]
        public int? OrderId { get; set; }
        [JsonIgnore]
        public Order? OrderDetail { get; set; }
        // [JsonIgnore]
        // public User? UserDetail { get; set; }
        [JsonIgnore]
        public Product? ProductDetail { get; set; }
    }
}
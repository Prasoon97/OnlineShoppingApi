using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace OnlineShoppingApi.Models
{
    public class Address
    {
        [Key]
        [JsonIgnore]
        public int Id { get; set; }
        [Required]
        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }
        [Required]
        public string City { get; set; }
        [Required]
        public string State { get; set; }
        [Required]
        public int ZipCode { get; set; }
        public string AddressType { get; set; }
        [JsonIgnore]
        [ForeignKey("OrderDetail")]
        public int OrderId { get; set; }
        [JsonIgnore]
        public Order? OrderDetail { get; set; }
    }

}
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace OnlineShoppingApi.Models
{
    public class PaymentDetail
    {
        [Key]
        [JsonIgnore]
        public int Id { get; set; }
        public decimal TotalAmount { get; set; }
        public string PaymentType { get; set; }

    }

}
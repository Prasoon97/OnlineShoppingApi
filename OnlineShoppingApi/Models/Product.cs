using System.ComponentModel.DataAnnotations;
using OnlineShoppingApi.Common;

namespace OnlineShoppingApi.Models
{
    public class Product
    {
        [Key]
        [Required]
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public Decimal Price { get; set; }
        public string? Description { get; set; }
        [Required]
        public string Category { get; set; }
        [Required]
        public DateTime DateAdded { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Minimum order value should be {1} or greater")]
        [IsLessThanOrEqualsValidation("MaxOrder")]
        public int? MinOrder { get; set; }
        [IsGreaterThanOrEqualsValidation("MinOrder")]
        [Range(1, int.MaxValue, ErrorMessage = "Maximum order value should be {1} or greater")]
        public int? MaxOrder { get; set; }

    }



}
using OnlineShoppingApi.Data;
using OnlineShoppingApi.Models;
using static OnlineShoppingApi.Common.Constants;

namespace OnlineShoppingApi.Service
{
    public class ProductService : IProductService
    {
        private readonly OnlineShoppingContext _context;
        public ProductService(OnlineShoppingContext context)
        {
            _context = context;
        }

        public IQueryable<Product> GetAllProducts(string orderBy)
        {
            IQueryable<Product> products;
            switch (orderBy)
            {
                case SortOrder.Asc:
                    products = _context.Products.OrderBy(p => p.Price);
                    break;
                case SortOrder.Desc:
                    products = _context.Products.OrderByDescending(p => p.Price);
                    break;
                default:
                    products = _context.Products;
                    break;
            }
            return products;
        }

        public Product GetProductById(int id)
        {
            return _context.Products.Find(id);
        }

        public IQueryable<Product> GetProductsByCategory(string category)
        {
            IQueryable<Product> products = _context.Products.Where(p => p.Category.ToLower().Contains(category.ToLower()));
            return products;
        }
        public bool AddProduct(Product product)
        {
            _context.Add(product);
            var result = _context.SaveChanges();
            return result > 0;
        }

        public bool AddProductsInBulk(IEnumerable<Product> productList)
        {
            _context.AddRange(productList);
            var result = _context.SaveChanges();
            return result > 0;
        }

        public bool DeleteProduct(int id)
        {
            var productToBeDeleted = _context.Products.FirstOrDefault(p => p.Id == id);
            if (productToBeDeleted != null)
            {
                _context.Products.Remove(productToBeDeleted);
                _context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }
    }
}
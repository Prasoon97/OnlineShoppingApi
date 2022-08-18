using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Service
{

    public interface IProductService
    {
        IQueryable<Product> GetAllProducts(string orderBy);
        Product GetProductById(int id);
        IQueryable<Product> GetProductsByCategory(string category);
        //To do Add product
        bool AddProduct(Product product);
        bool AddProductsInBulk(IEnumerable<Product> productList);
        bool DeleteProduct(int id);
    }

}
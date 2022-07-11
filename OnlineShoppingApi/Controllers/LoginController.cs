using Microsoft.AspNetCore.Mvc;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;

namespace OnlineShoppingApi.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _config;
        public LoginController(IConfiguration config)
        {
            _config = config;
        }

        [HttpPost]
        public async Task<IActionResult> Signup(User user)
        {
            string clientId = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.ClientId).Value;
            string dbConnection = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.Connection).Value;
            string url = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.SignupUrl).Value;

            HttpClient client = new HttpClient();

            HttpResponseMessage response = await client.PostAsJsonAsync(url, new { client_id = clientId, email = user.Email, password = user.Password, connection = dbConnection });
            object responseContent = await response.Content.ReadFromJsonAsync<object>();

            return StatusCode((int)response.StatusCode, responseContent);
        }

        [HttpPost]
        public async Task<IActionResult> GetAccessToken(User user)
        {
            string clientId = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.ClientId).Value;
            string clientSecret = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.ClientSecret).Value;
            string dbConnection = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.Connection).Value;
            string audience = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.Audience).Value;
            string url = _config.GetSection(ConfigKeys.AuthO).GetSection(ConfigKeys.AccessTokenUrl).Value;
            HttpClient client = new HttpClient();
            var data = new
            {
                grant_type = GrantType.Password,
                username = user.Email,
                password = user.Password,
                audience = audience,
                client_id = clientId,
                client_secret = clientSecret
            };

            HttpResponseMessage response = await client.PostAsJsonAsync(url, data);
            object responseContent = await response.Content.ReadFromJsonAsync<object>();

            return StatusCode((int)response.StatusCode, responseContent);
        }
    }
}
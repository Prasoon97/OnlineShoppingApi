using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using OnlineShoppingApi.Data;
using OnlineShoppingApi.Service;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// builder.Logging.ClearProviders();
// builder.Logging.AddConsole();
// builder.Logging.AddDebug();

var loggerConfiguration = new LoggerConfiguration().WriteTo.File(builder.Configuration["Serilog:LogPath"], rollOnFileSizeLimit:true,fileSizeLimitBytes:1000).
ReadFrom.Configuration(builder.Configuration)
.Enrich.FromLogContext().CreateLogger();

builder.Logging.ClearProviders();
builder.Logging.AddSerilog(loggerConfiguration);





// Add services to the container.

builder.Services.AddControllers();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
 {
     options.Authority = "https://onlineshopping-api.us.auth0.com/";
     options.Audience = "https://localhost:7062/";
 });

builder.Services.AddDbContext<OnlineShoppingContext>((options) =>
options.UseSqlServer(builder.Configuration.GetConnectionString("OnlineShoppingDatabase")));

builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ICartService, CartService>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("bearer", new OpenApiSecurityScheme
    {
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Scheme = "bearer"
    });

    options.OperationFilter<AddHeaderParameter>();
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseExceptionHandler("/error-development");
}
else{
   // app.UseExceptionHandler("/error");
}

app.UseHttpsRedirection();
app.UseAuthentication();

app.UseAuthorization();

using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<OnlineShoppingContext>();
    dbContext.Database.Migrate();
}

app.MapControllers();
//Logging Application start
var logger = app.Services.GetRequiredService<ILogger<Program>>();
logger.LogInformation("Application has started!!");

app.Run();

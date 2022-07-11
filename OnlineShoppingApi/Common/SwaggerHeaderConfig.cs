using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

public class AddHeaderParameter : IOperationFilter
{
    public void Apply(OpenApiOperation operation, OperationFilterContext context)
    {
        //Getting the methods having Authorize Attribute
        //It will be used to add security to only authorized method and show lock symbol only on them
        var authAttributes = context.MethodInfo.DeclaringType.GetCustomAttributes(true)
        .Union(context.MethodInfo.GetCustomAttributes(true))
        .OfType<AuthorizeAttribute>();

        if (authAttributes.Any())
        {
            if (operation.Security == null)
                operation.Security = new List<OpenApiSecurityRequirement>();


            var scheme = new OpenApiSecurityScheme { Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "bearer" } };
            operation.Security.Add(new OpenApiSecurityRequirement
            {
                [scheme] = new List<string>()
            });
        }
    }
}
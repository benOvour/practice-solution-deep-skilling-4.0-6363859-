﻿//This code is commented out as previously it has be run and results are shown in the screenshots .
//This code below is to do the initial inserts of te data to my database 

// using (var context = new AppDbContext())
// {
//     var electronics = new Category { Name = "Electronics" };
//     var groceries = new Category { Name = "Groceries" };

//     await context.Categories.AddRangeAsync(electronics, groceries);

//     var product1 = new Product { Name = "Laptop", Price = 75000, Category = electronics };
//     var product2 = new Product { Name = "Rice Bag", Price = 1200, Category = groceries };

//     await context.Products.AddRangeAsync(product1, product2);
//     await context.SaveChangesAsync();
// }

using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

class Program
{
    static async Task Main(string[] args)
    {
        using (var context = new AppDbContext())
        {
            // 1. Retrieve all products
            var products = await context.Products.ToListAsync();
            foreach (var p in products)
            {
                Console.WriteLine($"{p.Name} - ₹{p.Price}");
            }

            // 2. Find product by ID
            var product = await context.Products.FindAsync(1);
            Console.WriteLine($"Found: {product?.Name}");

            // 3. Find first expensive product
            var expensive = await context.Products.FirstOrDefaultAsync(p => p.Price > 50000);
            Console.WriteLine($"Expensive: {expensive?.Name}");
        }
    }
}
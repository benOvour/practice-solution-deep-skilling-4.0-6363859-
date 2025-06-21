using System;
using System.Collections.Generic;

public class InventoryManager
{
    private Dictionary<int, Product> inventory = new Dictionary<int, Product>();

    public void AddProduct(Product product)
    {
        if (!inventory.ContainsKey(product.ProductId))
        {
            inventory[product.ProductId] = product;
            Console.WriteLine("Product added.");
        }
        else
        {
            Console.WriteLine("Product with this ID already exists.");
        }
    }

    public void UpdateProduct(int id, string newName, int newQty, double newPrice)
    {
        if (inventory.ContainsKey(id))
        {
            var p = inventory[id];
            p.ProductName = newName;
            p.Quantity = newQty;
            p.Price = newPrice;
            Console.WriteLine("Product updated.");
        }
        else
        {
            Console.WriteLine("Product not found.");
        }
    }

    public void DeleteProduct(int id)
    {
        if (inventory.Remove(id))
        {
            Console.WriteLine("Product deleted.");
        }
        else
        {
            Console.WriteLine("Product not found.");
        }
    }

    public void DisplayInventory()
    {
        Console.WriteLine("\nCurrent Inventory:");
        foreach (var item in inventory.Values)
        {
            Console.WriteLine(item);
        }
    }
}

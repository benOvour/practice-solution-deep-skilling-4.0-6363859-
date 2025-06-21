using System;

class Program
{
    static void Main(string[] args)
    {
        InventoryManager manager = new InventoryManager();

        manager.AddProduct(new Product(101, "Laptop", 10, 79999.99));
        manager.AddProduct(new Product(102, "Mouse", 100, 499.50));
        manager.UpdateProduct(101, "Laptop Pro", 8, 84999.99);
        manager.DeleteProduct(102);

        manager.DisplayInventory();
    }
}

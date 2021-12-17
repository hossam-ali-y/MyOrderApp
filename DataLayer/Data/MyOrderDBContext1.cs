using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace DataLayer.Data
{
    public partial class MyOrderDBContext
    {
         public override Task<int> SaveChangesAsync(
                    bool acceptAllChangesOnSuccess,
                    CancellationToken cancellationToken = default(CancellationToken))
                {
                        var AddedEntities = ChangeTracker.Entries()
                            .Where(E => E.State == EntityState.Added)
                            .ToList();

                        AddedEntities.ForEach(E =>
                        {
                                var Properties = E.Entity.GetType().GetProperties();
                                foreach (var Property in Properties)
                                {
                                        if (Property.Name == "CreatedDate")
                                        {
                                                if (E.Property("CreatedDate").CurrentValue == null)
                                                        E.Property("CreatedDate").CurrentValue = DateTime.Now;
                                        }

                                }
                        });

                        var EditedEntities = ChangeTracker.Entries()
                            .Where(E => E.State == EntityState.Modified)
                            .ToList();

                        EditedEntities.ForEach(E =>
                        {
                                var Properties = E.Entity.GetType().GetProperties();
                                foreach (var Property in Properties)
                                {
                                        if (Property.Name == "ModifiedDate")
                                                E.Property("ModifiedDate").CurrentValue = DateTime.Now;
                                }
                        });

                        return base.SaveChangesAsync(acceptAllChangesOnSuccess, cancellationToken);
                }
        
    }
}
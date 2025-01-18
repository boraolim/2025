using Core.Domain.Constants;
using Core.Infrastructure.Attributes;

namespace Core.Infrastructure.Migrations;

[Tags("Core")]
[CustomMigration(2025, 3, 9, 11, 17,46)]
public class Migration1705447966 : Migration
{
    public override void Up()
    {
        Execute.EmbeddedScript($"{MainConstants.CFG_PATH_SCRIPTS_NAME}.{nameof(Migration1705447966)}.sql");
    }
    public override void Down()
    {
        // Execute.Sql("DROP TABLE TestTable;");
        throw new NotImplementedException();
    }
}

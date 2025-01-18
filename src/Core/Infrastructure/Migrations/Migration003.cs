using Core.Domain.Constants;
using Core.Infrastructure.Attributes;

namespace Core.Infrastructure.Migrations;

[Tags("Core")]
[CustomMigration(2025, 2, 3, 9, 46, 6)]
public class Migration003 : Migration
{
    public override void Down()
    {
        throw new NotImplementedException();
    }

    public override void Up()
    {
        Execute.EmbeddedScript($"{MainConstants.CFG_PATH_SCRIPTS_NAME}.{nameof(Migration003)}.sql");
    }
}

using Core.Domain.Constants;
using Core.Infrastructure.Attributes;

namespace Core.Infrastructure.Migrations;

[Tags("Core")]
[CustomMigration(2025, 2, 2, 1, 15, 36)]
public class Migration002 : Migration
{
    public override void Up()
    {
        Execute.EmbeddedScript($"{MainConstants.CFG_PATH_SCRIPTS_NAME}.{nameof(Migration002)}.sql");
    }
    public override void Down()
    {
        throw new NotImplementedException();
    }
}

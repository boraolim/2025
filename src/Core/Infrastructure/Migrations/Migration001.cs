using Core.Domain.Constants;
using Core.Infrastructure.Attributes;

namespace Core.Infrastructure.Migrations;

[Tags("Core")]
[CustomMigration(2025, 2, 1, 0, 1, 20)]
public class Migration001 : Migration
{
    public override void Up()
    {
        Execute.EmbeddedScript($"{MainConstants.CFG_PATH_SCRIPTS_NAME}.{nameof(Migration001)}.sql");
    }
    public override void Down()
    {
        throw new NotImplementedException();
    }
}

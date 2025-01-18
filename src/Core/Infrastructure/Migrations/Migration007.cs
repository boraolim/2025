using Core.Domain.Constants;
using Core.Infrastructure.Attributes;

namespace Core.Infrastructure.Migrations;

[Tags("Core")]
[CustomMigration(2025, 2, 6, 9, 55, 34)]
public sealed class Migration007 : Migration
{
    public override void Down()
    {
        throw new NotImplementedException();
    }
    public override void Up()
    {
        Execute.EmbeddedScript($"{MainConstants.CFG_PATH_SCRIPTS_NAME}.{nameof(Migration007)}.sql");
    }
}

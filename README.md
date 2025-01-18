# Clean Architecture in .NET Core 8.0

.Net Core Web API project to run on Windows, Linux or Mac, with the .NET Core compiler at version 8.0+ (it is currently compiled for .NET 8.0, at the time of this repository's creation).

## Characteristics:

* **Entity Framework is not used** for Database access and fluent migration.
* Using [Dapper](https://www.nuget.org/packages/Dapper) for Data access with the DbFactory and UnitOfWork design pattern.
* MariaDb or MySQL is used as the Database manager because it is the most used by developers due to its security levels and high performance. To connect to this database manager, [MySQLConnector](https://www.nuget.org/packages/MySqlConnector) is used.
* Use of [Fluent Migrator](https://www.nuget.org/packages/FluentMigrator) when starting the WebApi project with fluent migration taking into account that Native SQL is used.
* Use of Cache.
* Using Swagger for Local environment.
* The use of AutoMapper is little, so native data mapping is used.
* Use of SeriLog to log events in plain text file.
* Using Docker to run Backend, MariaDb or MySql and REDIS application with Docker.
* Using authentication and authorization via JWT Tokens.
* Using resilience techniques for proper operation. 

## Prerequisites

Download and run the following script to install a recent version of .NET Core on your Linux distribution that you are using:

```
$ sudo apt-get auto-remove -yq && sudo apt-get clean && sudo apt-get update -yq && sudo apt-get upgrade -yq
$ sudo apt install dotnet6 -yq && sudo apt install dotnet7 -yq && sudo apt install dotnet8 -yq
$ sudo dotnet --version
$ sudo dotnet --info
```

## Project structure and construction

Subsequently, you have to create a folder to build the skeleton of the Web API application with the following commands:

```
-- Create the project file.
$ sudo dotnet new sln --name CA.Project.sln

-- Create the folders.
$ sudo mkdir -p Backend/Core/{CA.Application.Core,CA.Domain.Core,CA.Infrastructure.Persistence.Core}/{bin,obj,Properties}
$ sudo mkdir -p Backend/Products/{CA.Application.Products,CA.Domain.Products,CA.Infrastructure.Common.Products,CA.Infrastructure.Persistence.Products,CA.WebApi.Products}/{bin,obj,Properties}

-- Create the following projects:
$ sudo dotnet new classlib -o Backend/Core/CA.Application.Core -name CA.Application.Core
$ sudo dotnet new classlib -o Backend/Core/CA.Domain.Core -name CA.Domain.Core
$ sudo dotnet new classlib -o Backend/Core/CA.Infrastructure.Persistence.Core -name CA.Infrastructure.Persistence.Core

$ sudo dotnet new classlib -o Backend/Products/CA.Application.Products -name CA.Application.Products
$ sudo dotnet new classlib -o Backend/Products/CA.Domain.Products -name CA.Domain.Products
$ sudo dotnet new classlib -o Backend/Products/CA.Infrastructure.Common.Products -name CA.Infrastructure.Common.Products
$ sudo dotnet new classlib -o Backend/Products/CA.Infrastructure.Persistence.Products -name CA.Infrastructure.Persistence.Products
$ sudo dotnet new webapi -o Backend/Products/CA.WebApi.Products -name CA.WebApi.Products

-- Add the projects to the solution.
$ sudo dotnet sln add Backend/Core/CA.Application.Core/CA.Application.Core.csproj
$ sudo dotnet sln add Backend/Core/CA.Domain.Core/CA.Domain.Core.csproj
$ sudo dotnet sln add Backend/Core/CA.Infrastructure.Persistence.Core/CA.Infrastructure.Persistence.Core.csproj
$ sudo dotnet sln add Backend/Products/CA.Application.Products/CA.Application.Products.csproj
$ sudo dotnet sln add Backend/Products/CA.Domain.Products/CA.Domain.Products.csproj
$ sudo dotnet sln add Backend/Products/CA.Infrastructure.Common.Products/CA.Infrastructure.Common.Products.csproj
$ sudo dotnet sln add Backend/Products/CA.Infrastructure.Persistence.Products/CA.Infrastructure.Persistence.Products.csproj
$ sudo dotnet sln add Backend/Products/CA.WebApi.Products/CA.WebApi.Products.csproj

-- Setting permissions per folder:
$ sudo chmod -R g+rwx Backend/Core/{CA.Application.Core,CA.Domain.Core,CA.Infrastructure.Persistence.Core}/
$ sudo chown -R $USER:$USER Backend/Core/{CA.Application.Core,CA.Domain.Core,CA.Infrastructure.Persistence.Core}/
$ sudo chmod -R g+rwx Backend/Core/{CA.Application.Core,CA.Domain.Core,CA.Infrastructure.Persistence.Core}/{bin,obj,Properties}
$ sudo chown -R $USER:$USER Backend/Core/{CA.Application.Core,CA.Domain.Core,CA.Infrastructure.Persistence.Core}/{bin,obj,Properties}
$ sudo chmod -R g+rwx Backend/Persons/{CA.Application.Persons,CA.Domain.Persons,CA.Infrastructure.Common.Persons,CA.Infrastructure.Persistence.Persons,CA.WebApi.Products}/
$ sudo chown -R $USER:$USER Backend/Persons/{CA.Application.Persons,CA.Domain.Persons,CA.Infrastructure.Common.Persons,CA.Infrastructure.Persistence.Persons,CA.WebApi.Products}/
$ sudo chmod -R g+rwx Backend/Persons/{CA.Application.Persons,CA.Domain.Persons,CA.Infrastructure.Common.Persons,CA.Infrastructure.Persistence.Persons,CA.WebApi.Products}/{bin,obj,Properties}
$ sudo chown -R $USER:$USER Backend/Persons/{CA.Application.Persons,CA.Domain.Persons,CA.Infrastructure.Common.Persons,CA.Infrastructure.Persistence.Persons,CA.WebApi.Products}/{bin,obj,Properties}

-- Writing and generate code per C# project and save changes.

-- Compile everything and run it.
$ sudo dotnet clean && sudo dotnet restore --force && sudo dotnet build
$ sudo dotnet run --project Backend/Products/CA.WebApi.Products/CA.WebApi.Products.csproj --launch-profile CA.Api.Local

-- Remove a C# project from a solution:
$ sudo dotnet sln remove Backend/Products/CA.WebApi.Products/CA.WebApi.Products.csproj

-- Publish for Production Environment:
$ sudo dotnet build --project Backend/Products/CA.WebApi.Products/CA.WebApi.Products.csproj -c Release -o /app/build
$ sudo dotnet publish --project Backend/Products/CA.WebApi.Products/CA.WebApi.Products.csproj -c Release -o /app/publish /p:UseAppHost=false --no-restore
```

Open the application in your browser by clicking [here](http://localhost:6063/swagger) (or on the port indicated by the project console).
**NOTE**. If you get this message when running the project::

```
The ASP.NET Core developer certificate is not trusted. For information about trusting the ASP.NET Core developer certificate, see https://aka.ms/aspnet/https-trust-dev-cert.
```

Run the following commands:

```
$ sudo dotnet dev-certs https
$ sudo -E dotnet dev-certs https -ep /usr/local/share/ca-certificates/aspnet/https.crt --format PEM
$ sudo update-ca-certificates

```

## Set environment variables system-wide
If you used the previous install script, the variables set only apply to your current terminal session. Add them to your shell profile. There are many different shells available for Linux and each has a different profile. For example:

* Bash Shell: ~/.bash_profile, ~/.bashrc
* Korn Shell: ~/.kshrc or .profile
* Z Shell: ~/.zshrc or .zprofile

Set the following two environment variables in your shell profile:

* **DOTNET_ROOT.** This variable is set to the folder .NET was installed to, such as $HOME/.dotnet:
```
$ sudo nano /home/user/.bashrc
export DOTNET_ROOT=$HOME/.dotnet
```

* **PATH.** This variable should include both the DOTNET_ROOT folder and the user's .dotnet/tools folder:
```
$ sudo nano /home/user/.bashrc
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
```
## Required Environment Variables

The KeyGenerator project, included in this repository, helps us create the main environment variables for the system to run correctly. By compiling it with this command:

```
$ sudo dotnet run --project KeyGenerator/KeyGenerator.csproj
```

We generate a JSON file with the following values:

```
{
    "MainSecretEnv": "Seed for AES GCM encryption",
    "DataBaseUrl": "Connection string to the Web API application database encrypted with AES GCM",
    "RootPassword": "Password of the Web API root user to be stored in the tb_users table",
    "ClientSecretKey": "Client name secret value for JWT",
    "Issuer": "Issuer value for JWT",
    "Audience": "Audience value for JWT"
}
```
The first two values ​​must be used as system environment variables in the local operating system or Docker container under the following names:

```
key_MAIN_SECRET_API = "Value from 'MainSecretEnv'"
key_MAIN_SECRET_DB_CONN = "Value from 'DataBaseUrl'"
```

The last three values ​​must be saved in the AppSettings.json file of the Web API application:

```
{
    "ClientSecretKey": "Your client JWT here...",
    "Issuer": "Your issuer here...",
    "Audience": "Your audiencie here..."
}
```
With these settings, the application is ready to run correctly.

## Database Configuration in a Local environment

You need to install MySQL or MariaDb to run the Database scripts and for the Web API project to work correctly. 
I recommend using a user account for the Application Database, rather than using the 'root' account.

Once the MySQL or MariaDb server is installed, run the SQL script called **init.sql** that comes in the **src\mariadb-init-scripts** folder to create the application Database. There define the password of the user called 'userapp'.

You close the root session and log in with the new user account just created.
You must configure the database connection in the **appSettings.Development.json**, **appSettings.QA.json**, and **appSettings.Production.json** files of each WebAPI project. Rebuild and run it. 
The profiles for this project are already configured in the **launchsettings.json** file of the Web API project.

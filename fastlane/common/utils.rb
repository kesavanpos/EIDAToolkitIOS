def snakeUpperCase (string)
  return string.gsub(/::/, '/').
    gsub(/([a-z])([A-Z\d])/,'\1_\2').
    gsub(/([A-Z])(\d)/,'\1_\2').
    gsub(/([\d])([A-Za-z])/,'\1_\2').
    tr("-", "_").
    tr(".", "_").
    upcase
end

def getCLIArgEnvName (argName)
  return "CLI_ARG_" + snakeUpperCase(argName) + "_9bea9086953e110697fbbf5f537ab878";
end

def getEnvVar (envVarName)
  result = 
      ENV[snakeUpperCase(envVarName) + "_9bea9086953e110697fbbf5f537ab878"] ||
      ENV[snakeUpperCase(envVarName)];

  return result;
end

def promoteBuildEnvVarForCurrentProcess (envVarName)
  envVarName = snakeUpperCase(envVarName);
  buildLevelEnvValue = ENV[envVarName + "_9bea9086953e110697fbbf5f537ab878"];
  if buildLevelEnvValue && buildLevelEnvValue != ""
    ENV[envVarName] = buildLevelEnvValue;
  end
end

def getCLIArgsFromEnv (argNames)
  cliArgs = [];
  argNames.each do |argName|
    envVarName = getCLIArgEnvName(argName);
    envVarValue = ENV[envVarName];
    if envVarValue && envVarValue != ""
      if envVarValue == "true"
        cliArgs.push("--#{argName}");
      elsif envVarValue == "false"
        cliArgs.push("--no-#{argName}");
      else
        cliArgs.push("--#{argName}", "\"$#{envVarName}\"");
      end
    end
  end

  return cliArgs;
end
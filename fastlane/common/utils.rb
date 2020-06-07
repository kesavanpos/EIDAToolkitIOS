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
  return "CLI_ARG_" + snakeUpperCase(argName) + "_00ea35fb19505f8692e4bd717fdb86ff";
end

def getEnvVar (envVarName)
  result = 
      ENV[snakeUpperCase(envVarName) + "_00ea35fb19505f8692e4bd717fdb86ff"] ||
      ENV[snakeUpperCase(envVarName)];

  return result;
end

def promoteBuildEnvVarForCurrentProcess (envVarName)
  envVarName = snakeUpperCase(envVarName);
  buildLevelEnvValue = ENV[envVarName + "_00ea35fb19505f8692e4bd717fdb86ff"];
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
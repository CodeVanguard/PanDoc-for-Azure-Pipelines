# Overview

An Azure Pipeline task that allows you to run the [PanDoc](https://pandoc.org/) tool in your pipelines.

## Installing PanDoc
If you do not have PanDoc already installed on your build agent, we've included a step which will download and install the latest version. Run the `InstallPanDoc` step to make sure the latest version of PanDoc is running.

```yaml
- task: InstallPanDoc@2
```

You can also specify the specific version of PanDoc you would like to install by using the `version` argument.

```yaml
- task: InstallPanDoc@2
  inputs:
    version: "3.8.0"
```

Underneath, this step is using chocolaty. If you want to see which versions are acceptable, run the following command:

```ps
choco search --exact pandoc --all
```

## Running PanDoc 

To run PanDoc, use the `RunPanDoc` task.

Below is a sample YAML entry for executing the PanDoc tool.

```yaml

- task: RunPanDoc@2
  displayName: Convert Github Markdown to HTML
  inputs:
    sourceFiles: '$(System.DefaultWorkingDirectory)/Test/test.md'
    inputFormat: 'gfm'
    outputFormat: 'html5'
    destFile: '$(Build.ArtifactStagingDirectory)/test.html'
    additionalArgs: '--toc'
    workingDirectory: '$(System.DefaultWorkingDirectory)'
```

### Arguments

Below are the arguments for the task, and the [corresponding argument in Pandoc](https://pandoc.org/MANUAL.html#general-options)

| Argument         | Description                                         | Corresponding PanDoc Command Line Argument |
|------------------|-----------------------------------------------------|--------------------------------------------|
| sourceFile       | The path to one or more files to convert.           |                                            |
| inputFormat      | The format of the source file.                      | -f                                         |
| outputFormat     | The format of the destination file.                 | -t                                         |
| destFile         | The (full) path where to save the new file.         | -o                                         |
| workingDirectory | The working directory where the command will be run |                                            |
| additionalArgs   | Additional arguments to pass along to pandoc        |                                            |

# License 
Copyright (C) 2020-2025 Code Vanguard LLC

All rights reserved
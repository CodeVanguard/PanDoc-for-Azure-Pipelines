# Overview

An Azure Pipeline task that allows you to run the [PanDoc](https://pandoc.org/) tool in your pipelines.

# Usage
The extensions supports use of the assistant view to help you to configure your PanDoc.

![Assistant view](images/assistant.png)

The assistant will help you to choose the supported input and output formats.

![Format parameters](images/formats.png)

# Sample YAML

Below is a sample YAML entry for executing the PanDoc tool.

```yaml
- task: RunPanDoc@1
  displayName: Convert Github Markdown to HTML
  inputs:
    sourceFile: '$(System.DefaultWorkingDirectory)/Test/test.md'
    inputFormat: 'gfm'
    outputFormat: 'html5'
    destFile: '$(Build.ArtifactStagingDirectory)/test.html'
```

# Argument

Below are the arguments for the task, and the [corresponding argument in Pandoc](https://pandoc.org/MANUAL.html#general-options)

| Argument     | Description                        | Corresponding PanDoc Command Line Argument |
|--------------|------------------------------------|--------------------------------------------|
| sourceFile   | The source file to convert.        |                                            |
| inputFormat  | The format of the source file.     | -f                                         |
| outputFormat | The desination format of the file. | -t                                         |
| destFile     | Where to save the new file.        | -o                                         |

# License 
Copyright (C) 2020-2022 Code Vanguard LLC

All rights reserved
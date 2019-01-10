class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: quartzite
baseCommand:
  - python
  - /quartzite/quartzite/quartzite.py
inputs:
  - id: bases
    type: string?
    inputBinding:
      position: 0
      prefix: '--bases'
  - id: input_readcount
    type: File
    inputBinding:
      position: 99
outputs:
  - id: output_vaf
    type: File?
    outputBinding:
      glob: output.vaf
label: quartzite
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: output.vaf
requirements:
  - class: DockerRequirement
    dockerPull: 'estorrs/quartzite:0.0.1'

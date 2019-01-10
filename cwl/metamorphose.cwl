class: Workflow
cwlVersion: v1.0
id: metamorphose
label: metamorphose
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: rna_bam
    type: File
    'sbg:x': -1711.779541015625
    'sbg:y': -1186.978515625
  - id: dna_bam
    type: File
    'sbg:x': -1701.724853515625
    'sbg:y': -581.52294921875
  - id: reference_fasta
    type: File
    'sbg:x': -1909.536865234375
    'sbg:y': -994.0737915039062
  - id: positions
    type: File
    'sbg:x': -1910.0408935546875
    'sbg:y': -830.0761108398438
outputs: []
steps:
  - id: slate
    in:
      - id: input_bam
        source: rna_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    'sbg:x': -1463.8311767578125
    'sbg:y': -1061.762939453125
  - id: slate_1
    in:
      - id: input_bam
        source: dna_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    'sbg:x': -1468
    'sbg:y': -736
  - id: quartzite
    in:
      - id: input_readcount
        source: slate_1/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1252
    'sbg:y': -732
  - id: quartzite_1
    in:
      - id: input_readcount
        source: slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1258
    'sbg:y': -1059
requirements: []

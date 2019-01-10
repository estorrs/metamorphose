class: Workflow
cwlVersion: v1.0
id: metamorphose
label: metamorphose
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: rna_a_bam
    type: File
    'sbg:x': -1804.238037109375
    'sbg:y': -1245.9420166015625
  - id: rna_t_bam
    type: File
    'sbg:x': -1808.0252685546875
    'sbg:y': -1113.8634033203125
  - id: dna_a_bam
    type: File
    'sbg:x': -1801.258544921875
    'sbg:y': -705.8907470703125
  - id: dna_t_bam
    type: File
    'sbg:x': -1807.6009521484375
    'sbg:y': -567.8361206054688
  - id: reference_fasta
    type: File
    'sbg:x': -1909.536865234375
    'sbg:y': -994.0737915039062
  - id: positions
    type: File
    'sbg:x': -1910.0408935546875
    'sbg:y': -830.0761108398438
outputs:
  - id: rna_a_output_vaf
    outputSource:
      - quartzite_2/output_vaf
    type: File?
    'sbg:x': -1117.65625
    'sbg:y': -1145
  - id: rna_t_output_vaf
    outputSource:
      - quartzite_1/output_vaf
    type: File?
    'sbg:x': -1116.653076171875
    'sbg:y': -990
  - id: dna_a_output_vaf
    outputSource:
      - quartzite/output_vaf
    type: File?
    'sbg:x': -1117
    'sbg:y': -819
  - id: dna_t_output_vaf
    outputSource:
      - quartzite_3/output_vaf
    type: File?
    'sbg:x': -1118.653076171875
    'sbg:y': -656
  - id: rna_a_filtered_bam
    outputSource:
      - slate_2/filtered_bam
    type: File?
    'sbg:x': -1255.87646484375
    'sbg:y': -1379.7415771484375
  - id: rna_t_filtered_bam
    outputSource:
      - slate/filtered_bam
    type: File?
    'sbg:x': -1256
    'sbg:y': -1264.617919921875
  - id: dna_t_filtered_bam
    outputSource:
      - slate_3/filtered_bam
    type: File?
    'sbg:x': -1258.2921142578125
    'sbg:y': -367.89886474609375
  - id: dna_a_filtered_bam
    outputSource:
      - slate_1/filtered_bam
    type: File?
    'sbg:x': -1262.606689453125
    'sbg:y': -502.3819885253906
steps:
  - id: slate
    in:
      - id: input_bam
        source: rna_t_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    'sbg:x': -1464.3424072265625
    'sbg:y': -981.7960815429688
  - id: slate_1
    in:
      - id: input_bam
        source:
          - dna_bam
          - dna_a_bam
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
    'sbg:y': -820.5736694335938
  - id: quartzite
    in:
      - id: input_readcount
        source: slate_1/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1260.0546875
    'sbg:y': -819.258544921875
  - id: quartzite_1
    in:
      - id: input_readcount
        source: slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1258
    'sbg:y': -989.1931762695312
  - id: slate_2
    in:
      - id: input_bam
        source: rna_a_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    'sbg:x': -1462
    'sbg:y': -1134.1805419921875
  - id: quartzite_2
    in:
      - id: input_readcount
        source: slate_2/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1263.3970947265625
    'sbg:y': -1143.029296875
  - id: slate_3
    in:
      - id: input_bam
        source: dna_t_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    scatter:
      - positions
    'sbg:x': -1471.6302490234375
    'sbg:y': -658.1072998046875
  - id: quartzite_3
    in:
      - id: input_readcount
        source: slate_3/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1264.1092529296875
    'sbg:y': -654.7102661132812
requirements:
  - class: ScatterFeatureRequirement
  - class: MultipleInputFeatureRequirement

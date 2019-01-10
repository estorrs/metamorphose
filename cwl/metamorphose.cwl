class: Workflow
cwlVersion: v1.0
id: metamorphose
label: metamorphose
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: reference_fasta
    type: File
    'sbg:x': -1909.536865234375
    'sbg:y': -994.0737915039062
  - id: positions
    type: File
    'sbg:x': -1910.0408935546875
    'sbg:y': -830.0761108398438
  - id: dna_a_input_bam
    type: File
    'sbg:x': -1781.651611328125
    'sbg:y': -681.138671875
  - id: dna_t_input_bam
    type: File
    'sbg:x': -1784.9244384765625
    'sbg:y': -546.8587646484375
  - id: rna_t_input_bam
    type: File
    'sbg:x': -1783.3668212890625
    'sbg:y': -1115.5501708984375
  - id: rna_a_input_bam
    type: File
    'sbg:x': -1783.45849609375
    'sbg:y': -1236
outputs:
  - id: rna_a_output_vaf
    outputSource:
      - rna_a_quartzite/output_vaf
    type: File?
    'sbg:x': -1117.65625
    'sbg:y': -1145
  - id: rna_t_output_vaf
    outputSource:
      - rna_t_quartzite/output_vaf
    type: File?
    'sbg:x': -1116.653076171875
    'sbg:y': -990
  - id: dna_a_output_vaf
    outputSource:
      - dna_a_quartzite/output_vaf
    type: File?
    'sbg:x': -1117
    'sbg:y': -819
  - id: dna_t_output_vaf
    outputSource:
      - dna_t_quartzite/output_vaf
    type: File?
    'sbg:x': -1118.653076171875
    'sbg:y': -656
steps:
  - id: rna_t_slate
    in:
      - id: input_bam
        source: rna_t_input_bam
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
  - id: dna_a_slate
    in:
      - id: input_bam
        source: dna_a_input_bam
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
  - id: dna_a_quartzite
    in:
      - id: input_readcount
        source: dna_a_slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1260.0546875
    'sbg:y': -819.258544921875
  - id: rna_t_quartzite
    in:
      - id: input_readcount
        source: rna_t_slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1258
    'sbg:y': -989.1931762695312
  - id: rna_a_slate
    in:
      - id: input_bam
        source: rna_a_input_bam
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
  - id: rna_a_quartzite
    in:
      - id: input_readcount
        source: rna_a_slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    'sbg:x': -1263.3970947265625
    'sbg:y': -1143.029296875
  - id: dna_t_slate
    in:
      - id: input_bam
        source: dna_t_input_bam
      - id: positions
        source: positions
      - id: reference_fasta
        source: reference_fasta
    out:
      - id: readcount
      - id: filtered_bam
    run: ./slate.cwl
    label: slate
    'sbg:x': -1471.6302490234375
    'sbg:y': -658.1072998046875
  - id: dna_t_quartzite
    in:
      - id: input_readcount
        source: dna_t_slate/readcount
    out:
      - id: output_vaf
    run: ./quartzite.cwl
    label: quartzite
    scatter:
      - bases
    'sbg:x': -1264.1092529296875
    'sbg:y': -654.7102661132812
requirements:
  - class: ScatterFeatureRequirement

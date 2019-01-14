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
  - id: table_output
    outputSource:
      phyllite/table_output
    type: File?
    'sbg:x': -855.859619140625
    'sbg:y': -988.9166870117188
  - id: json_output
    outputSource:
      phyllite/json_output
    type: File?
    'sbg:x': -857.8939819335938
    'sbg:y': -799.717529296875
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
    'sbg:x': -1264.1092529296875
    'sbg:y': -654.7102661132812
  - id: phyllite
    in:
      - id: dna_normal_vaf
        source: dna_a_quartzite/output_vaf
      - id: dna_tumor_vaf
        source: dna_t_quartzite/output_vaf
      - id: rna_normal_vaf
        source: rna_a_quartzite/output_vaf
      - id: rna_tumor_vaf
        source: rna_t_quartzite/output_vaf
      - id: min_depth
        default: 10
      - id: max_dna_minor_vaf
        default: 0.001
      - id: min_rna_minor_vaf
        default: '.05'
    out:
      - id: table_output
      - id: json_output
    run: ./phyllite.cwl
    label: phyllite
    'sbg:x': -1022.6486206054688
    'sbg:y': -890
requirements: []

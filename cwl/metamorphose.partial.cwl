class: Workflow
cwlVersion: v1.0
id: metamorphose_partial
label: metamorphose_partial
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
  - id: dna_t_input_bam
    type: File
    'sbg:x': -1784.9244384765625
    'sbg:y': -546.8587646484375
  - id: rna_t_input_bam
    type: File
    'sbg:x': -1783.3668212890625
    'sbg:y': -1115.5501708984375
  - id: repeats_table
    type: File?
    'sbg:x': -818.4765625
    'sbg:y': -1154
  - id: primary_transcripts
    type: File?
    'sbg:x': -816
    'sbg:y': -1037
outputs:
  - id: json_output
    outputSource:
      phyllite/json_output
    type: File?
    'sbg:x': -857.8939819335938
    'sbg:y': -799.717529296875
  - id: table_output
    outputSource:
      annotation_station/output_file
    type: File?
    'sbg:x': -513.2862548828125
    'sbg:y': -989
steps:
  - id: rna_t_slate
    in:
      - id: min_base_quality
        default: 25
      - id: min_mapping_quality
        default: 20
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
  - id: dna_t_slate
    in:
      - id: min_base_quality
        default: 25
      - id: min_mapping_quality
        default: 20
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
      - id: dna_tumor_vaf
        source: dna_t_quartzite/output_vaf
      - id: rna_tumor_vaf
        source: rna_t_quartzite/output_vaf
      - id: min_depth
        default: 10
      - id: max_dna_minor_count
        default: 1
      - id: max_dna_minor_vaf
        default: 0.1
      - id: min_rna_minor_count
        default: 3
      - id: min_rna_minor_vaf
        default: '.1'
    out:
      - id: table_output
      - id: json_output
    run: ./phyllite.cwl
    label: phyllite
    'sbg:x': -1022.6486206054688
    'sbg:y': -890
  - id: annotation_station
    in:
      - id: input_type
        default: tsv
      - id: input_header
        default: true
      - id: annotate_repeats
        default: true
      - id: repeats_table
        source: repeats_table
      - id: annotate_transvar
        default: true
      - id: primary_transcripts
        source: primary_transcripts
      - id: input_file
        source: phyllite/table_output
    out:
      - id: output_file
    run: ./annotation_station.cwl
    label: annotation-station
    'sbg:x': -655
    'sbg:y': -988
requirements: []

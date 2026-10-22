# seq_tools

In-house scripts developed for sequence work at the **Hazra Lab, IIT Roorkee**: fetching protein sequences from databases, filtering and standardising FASTA files, summarising them, preparing alignments, and finding mutations.

The scripts were written one at a time for individual projects (β-lactamases, malic enzyme, xylose reductase, PHA synthase and others), so they are kept as they were written. Most read a hard-coded input file name near the top of the script and write fixed output file names. Edit those lines before running a script on new data.


## Layout

| Folder | Purpose |
|---|---|
| `fasta_filtering/` | Filter UniProt or GenBank FASTA files by organism, keyword, or gene name |
| `fasta_stats_and_alignment/` | Length statistics, length-window filtering for MSA, and alignment export to Excel |
| `mutation_finder/` | MATLAB alignment and mutation analysis of protein sequences |
| `utilities/` | Small helpers: BLDB sequence retrieval (`bldb_retrieval/`), split a multi-FASTA file, locate a gene in a genome, split peptide lists by length |


## fasta_filtering/

All of these split the FASTA file into records, apply a rule, and write the kept and excluded records to separate files.

| Script | Rule | Output |
|---|---|---|
| `uni_OS_filter_prog.pl` | Keeps records whose header matches a keyword (set in `$find`, e.g. `malic enzyme`) and keeps **one sequence per organism** (UniProt `OS=` field) | `OS_all_ME.fasta`, `Del_OS_all_ME.fasta` |
| `orgi_filter.pl` | For GenBank or BLAST headers with `[Organism]`: splits records into single-organism, repeated-organism, and no-organism sets | `single_organism_input.fasta`, `repeated_organism_input.fasta`, `non_organism_input.fasta`, `organism_list.docx` (plain text) |
| `mallic.pl` | Keeps records containing the words `malic` / `Malic` and drops fragments | `malic.fasta` |
| `xrdata_edit.pl` | Keeps records containing `xylose` / `reductase` terms and drops fragments | `xylose_reductase_wo_farg.fasta` |
| `xr_prog.pl` | Keeps `D-xylose reductase` records of 250–450 residues, one per organism (yeast set) | `ttxr_yeast.fasta`, `ttdeleted_xr.fasta` |
| `supplementary_1.pl` | Near-identical earlier copy of `xr_prog.pl` | same as `xr_prog.pl` |
| `xr_yeast_prog.pl` | Filters PHA synthase / polymerase FASTA files by organism name (`Bacillus`) | filtered FASTA files |
| `gene_name_list.pl` | Lists the unique gene names in a UniProt FASTA, skipping `putative` and `fragment` entries | `gene_list.txt` |

Despite its name, `xr_yeast_prog.pl` is the template that was reused for several projects. Check the `open(...)` lines at the top to see which files it reads.

**Requirements:** Perl 5 only.


## fasta_stats_and_alignment/

| Script | What it does | Output |
|---|---|---|
| `seq_len.pl` | Prints the number of sequences and the minimum, maximum and average length | terminal |
| `seq_msa.pl` | Keeps sequences inside a length window (`$min_limit` to `$max_limit`) so that fragments and over-long entries don't distort the multiple sequence alignment | `LR_*.fasta` (kept), `Del_LR_*.fasta` (excluded) |
| `excel_data.pl` | Exports an alignment FASTA to Excel with one residue per cell, so conserved columns can be coloured and inspected | `aln_70_above.xlsx` |

**Requirements:** Perl with `Spreadsheet::WriteExcel` and `Excel::Writer::XLSX` (for `excel_data.pl`).


## mutation_finder/

`alignmenttest.m` aligns the input protein sequences and writes the mutation-analysis tables. It is a MATLAB script, kept unchanged.

- Files: `alignmenttest.m`, plus two example inputs: `clsA_nw-seq-protein.fasta` and `clsA_nw-seq-protein_mod.fasta`.
- Requires MATLAB with the Bioinformatics Toolbox (`fastaread`, `seqpdist`, `seqlinkage`, `multialign`).
- Run: start MATLAB with `mutation_finder/` as the current folder, run `alignmenttest.m`, and enter the FASTA file name when prompted (for example `clsA_nw-seq-protein_mod.fasta`).
- It writes alignment (`.aln`) and CSV files into the current folder. Check them before adding them to version control.


## utilities/

### utilities/bldb_retrieval/

Download β-lactamase sequences from BLDB and standardise the FASTA headers.

| Script | What it does | Input → output |
|---|---|---|
| `bldb_extract.py` | Downloads protein sequences from [BLDB](http://www.bldb.eu) for every ID listed in each `*.list` file | `<gene>.list` (one BLDB ID per line) → `<gene>-seq-protein.fasta` |
| `wt_bldb_extract.py` | Same download for a single wild-type list; logs IDs that fail | list file → `wild_type-mod.fasta`, `WT-error.txt` |
| `header_rename.py` | Rewrites BLDB headers into one format, `>Organism\|ID\|gene\|hlab_BL-B1-<n>`, so sequences from different sources can be combined | `*-seq-protein.fasta` → `*-seq-protein_mod.fasta` |

`bldb_extract.py` and `wt_bldb_extract.py` are **Python 2** (`urllib2`, `print` statements). `wt_bldb_extract.py` has an absolute list-file path that needs editing. `header_rename.py` runs on Python 3.

### Other helpers

| Script | What it does |
|---|---|
| `uniprot_sep_fasta.py` | Splits a multi-FASTA file into one file per UniProt accession (`<accession>.fasta`). Requires Biopython. |
| `find_position.pl` | Finds the position of a gene sequence in a genome FASTA and writes a 60-nt window that starts 50 nt before the gene (`forward_seq.fasta`), for primer or flanking-region work. File names are set at the top. |
| `split_seq.py` | Splits per-protease peptide lists (pepsin, elastase, chymotrypsin, papain and others) into separate files by peptide length (2, 3, 4 and 5 residues). It is **Python 2** style: it uses relative paths and expects the peptide files in the current folder. |



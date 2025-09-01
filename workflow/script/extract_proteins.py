#!/usr/bin/env python3
import os
import argparse
from Bio import SeqIO

def extract_proteins_and_organisms(gbk_dir, output_file):
    protein_entries = []
    for filename in os.listdir(gbk_dir):
        if filename.endswith(".gbk"):
            filepath = os.path.join(gbk_dir, filename)
            for record in SeqIO.parse(filepath, "genbank"):
                for feature in record.features:
                    if feature.type == "CDS" and "translation" in feature.qualifiers:
                        protein_seq = feature.qualifiers["translation"][0]

                        # 获取物种信息
                        organism = record.features[0].qualifiers.get("organism", ["Unknown"])[0]

                        # 获取蛋白标识符：优先使用 locus_tag，其次 protein_id
                        #locus_tag = feature.qualifiers.get('locus_tag', ['unknown'])[0]
                        protein_id = feature.qualifiers.get('protein_id', ['unknown'])[0]
                        protein_identifier = protein_id  # 你也可以用 protein_id，如：protein_identifier = protein_id

                        # 构造 header: 蛋白标识符_物种
                        header = f">{protein_identifier}_{organism}"
                        protein_entries.append(f"{header}\n{protein_seq}\n")

    # 写入到输出文件
    with open(output_file, "w") as f:
        f.writelines(protein_entries)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="从 GBK 文件中提取蛋白质序列和物种信息")
    parser.add_argument("--gbk-dir", required=True, help="包含 GBK 文件的目录")
    parser.add_argument("--output", required=True, help="输出的蛋白质 FASTA 文件路径")
    args = parser.parse_args()

    extract_proteins_and_organisms(args.gbk_dir, args.output)

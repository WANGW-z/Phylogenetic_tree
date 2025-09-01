library(ggplot2)
library(ggtree)

#设置保存路径
project="tree" #项目名称
output_dir=paste0("/your/path/workflow/result/", project)

# 创建目录（如果不存在）
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}
# 设置工作目录
setwd(output_dir)
getwd()

#清理环境变量
rm(list=ls())

#读入绘图数据
tree <- read.tree("/your/path/workflow/result/phylogeny/tree.nwk")
ggtree(tree)


#直角形的
library(ggtree)
library(ape)

# 绘制带有分支长度的矩形树
p <- ggtree(tree, layout = "rectangular", branch.length = "branch.length") +
  ggtitle("Full Tree with All Information (Protein IDs, Bootstrap, Structure)")

# 1. 显示 tip label（蛋白ID）
p <- p + geom_tiplab(hjust = -0.02, size = 3.5, align = TRUE, color = "black")

# 2. 显示内部节点支持值（数字），直接使用 tree$node.label
p <- p + 
  geom_text2(
    aes(subset = !isTip),
    label = tree$node.label,
    hjust = -0.3,  # 调整偏移，避免跑到画布外
    size = 3,
    color = "darkred",
    fontface = "bold"
  )

# 3. 可选：用红点标记内部节点
p <- p + 
  geom_point2(aes(subset = !isTip), fill = "red", shape = 21, size = 3)

# 4. 可选：扩大 x 轴范围，防止节点或标签被裁剪
p <- p + xlim(0, 10)  # 根据你的 tip 数量调整，比如 32 tips → 0~40

# 显示图像（在 RStudio 中查看）
p

# ✅ 保存为高清 PDF 或 PNG（推荐！画布变大，所有内容显示完整）
# 比如：宽度=14英寸，高度=10英寸 → 适合 30+ tips 的树
ggsave("tree_with_support_values-1.pdf", plot = p, width = 14, height = 10, dpi = 300)


#树杈型的
# 绘制带有分支长度的矩形树
p <- ggtree(tree, layout="slanted", branch.length = "branch.length") +
  ggtitle("Full Tree with All Information (Protein IDs, Bootstrap, Structure)")

# 1. 显示 tip label（蛋白ID）
p <- p + geom_tiplab(hjust = -0.02, size = 3.5, align = TRUE, color = "black")

# 2. 显示内部节点支持值（数字），直接使用 tree$node.label
p <- p + 
  geom_text2(
    aes(subset = !isTip),
    label = tree$node.label,
    hjust = -0.3,  # 调整偏移，避免跑到画布外
    size = 3,
    color = "darkred",
    fontface = "bold"
  )

# 3. 可选：用红点标记内部节点
p <- p + 
  geom_point2(aes(subset = !isTip), fill = "red", shape = 21, size = 3)

# 4. 可选：扩大 x 轴范围，防止节点或标签被裁剪
p <- p + xlim(0, 10)  # 根据你的 tip 数量调整，比如 32 tips → 0~40

# 显示图像（在 RStudio 中查看）
p

# ✅ 保存为高清 PDF 或 PNG（推荐！画布变大，所有内容显示完整）
# 比如：宽度=14英寸，高度=10英寸 → 适合 30+ tips 的树
ggsave("tree_with_support_values-2.pdf", plot = p, width = 14, height = 10, dpi = 300)
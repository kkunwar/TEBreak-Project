# Miniconda installation:

wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh
conda create -n TEBreak_packages
conda activate TEBreak_packages 



 
#Python libraries:

conda install python==3.7.11
conda install pysam
conda install scipy
conda install scikit-bio
pip install bx-python




#LAST aligner

wget http://last.cbrc.jp/last-716.zip
unzip last-716.zip
cd last-716
make CXXFLAGS=-O3 -C last-716

#some files needs to be copied manually
cp $last-716/src/{lastal,lastdb,last-split,last-merge-batches,last-pair-probs} $TEBreak_packages/bin 

cp $last-716/scripts/{fastq-interleave,last-dotplot,last-map-probs,last-postmask,last-train,maf-convert,maf-join,maf-sort,maf-swap,parallel-fasta,parallel-fastq} $TEBreak_packages/bin
cd ..


#HTSLIB/SAMtools/BCFtools
git clone https://github.com/samtools/htslib.git
git clone https://github.com/samtools/samtools.git
git clone https://github.com/samtools/bcftools.git


cd htslib
git submodule update --init --recursive
git checkout v1.14
autoreconf 
./configure 
make install htslib

cp -r $htslib/htslib $TEBreak_packages/include
cd ..

cd samtools
git checkout v1.14
autoreconf
./configure
make install samtools

cp $samtools/samtools $TEBreak_packages/bin
cd ..

cd bcftools
git checkout v1.14
autoreconf 
./configure
make install bcftools

cp $bcftools/bcftools $TEBreak_packages/bin
cd ..



#Minia sequence assembler

wget https://github.com/GATB/minia/releases/download/v2.0.7/minia-v2.0.7-bin-Linux.tar.gz
tar -xvf minia-v2.0.7-bin-Linux.tar.gz

cp  $minia-v2.0.7-bin-Linux/bin/{dbgh5,dbginfo,h5dump,minia} $TEBreak_packages/bin




#Exonerate aligner

git clone https://github.com/adamewing/exonerate.git
cd exonerate
git checkout v2.2.0
autoreconf -i
./configure && make && make check 

cp $exonerate/doc/man/man1/{exonerate.1,ipcress.1,exonerate-server.1,fastautils.1} $TEBreak_packages/bin
cd ..



#TEBreak

git clone https://github.com/adamewing/tebreak.git
cd tebreak
git checkout v1.1
python setup.py build
python setup.py install
cd ..

# Installation successful!!

#Installation test 

tebreak -b $tebreak/test/data/example.ins.bam -r $tebreak/test/data/Homo_sapiens_chr4_50000000-60000000_assembly19.fasta -i $tebreak/lib/teref.human.fa

#this will produce four output files in the working directory




#Picard 



















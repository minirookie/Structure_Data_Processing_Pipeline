source /opt/phenix-1.12-2829/phenix_env.sh      #change accordingly if the version on the computer used is different
source /opt/ccp4/ccp4-7.0/bin/ccp4.setup-sh

phenix.refine /mnt/auto/data_diectory/MFP013_03-13_MRmodelEdit_Ver3.pdb \
input.sequence.file_name="/mnt/auto/data_diectory/hTRAP1CTDInfo/MFP013.fasta" \
input.xray_data.labels='/mnt/auto/data_diectory/MFP013IADPsoaking_02-04_2LoopsMonomerMR_2nmol.mtz:F(+),SIGF(+),F(-),SIGF(-),merge' \

xray_data.force_anomalous_flag_to_be_equal_to=true \
refinement.input.xray_data.convert_to_non_anomalous_if_ratio_pairs_lone_less_than_threshold=0.2 \
output.serial=1 \
output.prefix=IADP013_02-04_RefineInitRun01 \
xray_data.r_free_flags.generate=true \
xray_data.r_free_flags.fraction=0.05 \
xray_data.r_free_flags.disable_suitability_test=false \

refinement.main.number_of_macro_cycles=2 nproc=6 \
optimize_mask=true \
write_eff_file=true write_geo_file=true write_model_cif_file=true \
write_def_file=true write_maps=false write_map_coefficients=true \
anom_map_type=llg \

refinement.refine.strategy=individual_sites+individual_sites_real_space+individual_adp+occupancies+tls \
adp.individual.anisotropic="not water and not element H" \
optimize_xyz_weight=true optimize_adp_weight=true \
ordered_solvent=false ordered_solvent.mode=second_half \
refinement.ordered_solvent.output_chain_id=D \
simulated_annealing=false simulated_annealing.mode=first \
simulated_annealing.start_temperature=4000 \

# More commands for set up parameters
#/mnt/auto/data_diectory/AllFrame_IADP013_002-04_free.mtz \  #optional commands for references
#/mnt/auto/data_diectory/group_se_1.params \                 #optional commands for more parameters
#xray_data.force_anomalous_flag_to_be_equal_to=true \
#anomalous_scatterers.group.selection="element SE" \
#anomalous_scatterers.group.f_prime=-24.99 \
#anomalous_scatterers.group.f_double_prime=7.99 \
#anomalous_scatterers.group.refine=f_prime+f_double_prime \
#wxc_scale=5 wxu_scale=10 \

#Commands to run Phenix on HPC, with a For loop function
module load ccp4/7.0 xds/2019 phenix/1.14-3260    
source phenix_env.sh
source /hpcf/authorized_apps/rhel7_apps/ccp4/ccp4-7.0/bin/ccp4.setup-sh   #the HPC package setup/version

for i in 006-003 006-009 006-013 006-001
do
        cd "/research/home/data_directory/$i"
        pwd

phenix.phaser HKLI /research/home/data_directory/$i/DataFiles/AUTOMATIC_DEFAULT_free.mtz \
ENSE Jak2JH1 PDB /research/home/data_directory/Jak2JH1SearchEnsemble.pdb \
IDEN 0.9 COMP PROT SEQ /research/home/data_directory/MFP053.fasta \
NUM 1 SEAR ENSE Jak2JH1 NUM 1 \
SPAC P3121 SGAL ALL \
ROOT Ruxo$i-EnseSearch \

done

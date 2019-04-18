#!/usr/bin/env nextflow



/**
 * Create channel for input files.
 */
EMX_FILES = Channel.fromFilePairs("${params.input_dir}/*.emx", size: 1, flat: true)



/**
 * Send input files to each process that uses them.
 */
EMX_FILES
	.into {
		EMX_FILES_FOR_BSIZE
	}



/**
 * The bsize process performs a single run of KINC with a
 * specific work block size.
 */
process bsize {
	tag "${dataset}/${bsize}"
	publishDir "${params.output_dir}/${dataset}"

	input:
		set val(dataset), file(emx_file) from EMX_FILES_FOR_BSIZE
		each(bsize) from Channel.from( params.bsize.values )

	when:
		params.bsize.enabled == true

	script:
		"""
		kinc settings set cuda 0
		kinc settings set threads ${params.defaults.threads}
		kinc settings set buffer 4
		kinc settings set logging off

		kinc run similarity \
			--input ${emx_file} \
			--ccm ${dataset}.ccm \
			--cmx ${dataset}.cmx \
			--clusmethod ${params.defaults.clusmethod} \
			--corrmethod ${params.defaults.corrmethod} \
			--preout true \
			--postout true \
			--bsize ${bsize} \
			--gsize ${params.defaults.gsize} \
			--lsize ${params.defaults.lsize}
		"""
}

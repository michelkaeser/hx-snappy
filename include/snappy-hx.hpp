#ifndef __SNAPPY_HX_HPP
#define __SNAPPY_HX_HPP

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Compresses the bytes (which are 'length' in size).
 *
 * Example:
 *   value compressed = hx_snappy_compress(buffer_val(buf), buffer_size(buf));
 *
 * Parameters:
 *   value[haxe.io.BytesData] bytes  the bytes to compress
 *   value[int]               length the number of bytes to compress
 *
 * Returns:
 *   value[haxe.io.BytesData] the compressed bytes
 *   or [int] if an error encountered (and a Neko error is raised)
 */
value hx_snappy_compress(value bytes, value length);


/*
 * Decompresses the bytes (which are 'length' in size).
 *
 * Example:
 *   value compressed   = hx_snappy_compress(...);
 *   value uncompressed = hx_snappy_uncompress(compressed, buffer_size(val_to_buffer(compressed)));
 *
 * Parameters:
 *   value[haxe.io.BytesData] compressed        the bytes to uncompress
 *   value[int]               compressed_length the number of compressed bytes
 *
 * Returns:
 *   value[haxe.io.BytesData] the uncompressed bytes
 *   or [int] if an error encountered (and a Neko error is raised)
 */
value hx_snappy_uncompress(value compressed, value compressed_length);


/*
 * Validates that the compressed bytes can be uncompressed.
 *
 * This check is about 4x faster than uncompression itself.
 *
 * Example:
 *   value compressed = hx_snappy_compress(...);
 *   value valid      = hx_snappy_validate(compressed, buffer_size(val_to_buffer(compressed)))
 *   if (val_int(valid) == 0) {
 *     // uncompress
 *   }
 *
 * Parameters:
 *   value[haxe.io.BytesData] compressed        the compressed bytes to validate
 *   value[int]               compressed_length the number of compressed bytes
 *
 * Returns:
 *   value[int] the snappy_status code (0 == valide bytes)
 */
value hx_snappy_validate(value compressed, value compressed_length);

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* __SNAPPY_HX_HPP */

Our objective is to fit a linear classifier on data with a native dimensionality of 50,010,000. This data is very sparse, and so very often there are only columns with data numbering in the tens of thousands. 

50.01e6 is a lot of parameters to optimize, and 50,000,000 zeros in a dense data structure consume a lot of space. We attempted to solve this with the following approach.

## A keras layer reducing the space
This approach leverages Tensorflow Transform, using `tft.compute_and_apply_vocabulary` on tensors of index ids, mapping IDs in (0,50010000) down to the smallest possible continuous space, on the order of (0,40000). Because rows have differing lengths, I believe this layer outputs a `RaggedTensor`, expressed by TFX as a `SparseTensor`.

It is assumed that all values in a feature vector are 1 or 0, and so the output of the `tft` layer is simply the IDs.

This `SparseTensor` is then consumed by our custom `SparseConstructorLayer`, which creates a fixed-size `SparseTensor` with 40,000 columns and values in (0,1). 

The problem with this approach is that keras in TFX cannot seem to use this `SparseTensor`, and so the model won't fit.


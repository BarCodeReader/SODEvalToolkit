# A More Powerful Evaluation Toolbox for Salient Object Detection

**NOTE**: An fast and flexible implementation based python: <https://github.com/lartpang/PySODMetrics>

More details can be found at the origin repository:  https://github.com/ArcherFMY/sal_eval_toolbox

This forked repository mainly adds the following new features:
* More metrics: E-measure and weighted F-measure.
* Support for drawing according to existing mat files.
* Support custom threshold to binarize masks. Because the masks of some datasets are not exactly a binary map.

## changelos

* 2020/4/16:
    + `tools/ README.md`
        + Fixed the description: *Plot these value: You can run draw_mat.m draw_twice.m in matlab* -> *Plot these value: You can run `draw_curves.m` in matlab*
        + Supplement the description of **NOTE**, about the exported figure.
        + Add a piece of content to **HOW TO USE**.
    + Delete some useless files.

## Cite This Repo

**If you find this code useful in your research, please consider citing:**

```
@article{sal_eval_toolbox,
    Author = {Mengyang Feng},
    Title = {Evaluation Toolbox for Salient Object Detection.},
    Journal = {https://github.com/ArcherFMY/sal_eval_toolbox},
    Year = {2018}
}
```

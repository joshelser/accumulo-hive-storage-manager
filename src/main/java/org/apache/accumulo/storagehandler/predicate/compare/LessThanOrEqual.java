package org.apache.accumulo.storagehandler.predicate.compare;

/**
 * Created with IntelliJ IDEA.
 * User: bfemiano
 * Date: 4/22/13
 * Time: 1:46 AM
 * To change this template use File | Settings | File Templates.
 */
public class LessThanOrEqual implements CompareOp {

    private PrimativeCompare comp;

    public LessThanOrEqual(PrimativeCompare comp) {
        this.comp = comp;
    }

    @Override
    public void setPrimativeCompare(PrimativeCompare comp) {
       this.comp = comp;
    }

    @Override
    public PrimativeCompare getPrimativeCompare() {
        return comp;
    }

    @Override
    public boolean accept(byte[] val) {
        return comp.lessThanOrEqual(val);
    }
}
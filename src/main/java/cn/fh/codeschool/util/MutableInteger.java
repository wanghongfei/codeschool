package cn.fh.codeschool.util;

/**
 * 值可变的整数，用于提高Map计数器的计算效率
 * @author whf
 *
 */
public class MutableInteger implements Comparable<MutableInteger> {
	private int value;
	
	public MutableInteger(int val) {
		this.value = val;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	/**
	 * 比较两个对象所保存值的大小
	 */
	@Override
	public int compareTo(MutableInteger o) {
		return this.value - o.value;
	}
}

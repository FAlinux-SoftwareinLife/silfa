package screen.measure.connectivity {

	import abstracts.MeasureAbstract;

	import identifier.MeasureName;

	public class ConnectivityMeasure extends MeasureAbstract {

		private const MEASURE_NAME:String = MeasureName.CONNECTIVITY;

		public function ConnectivityMeasure() {
			super(MEASURE_NAME);
		}
	}
}

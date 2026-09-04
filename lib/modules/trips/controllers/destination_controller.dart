import 'package:get/get.dart';
import '../../../../shared/enums/view_state.dart';
import '../data/repositories/trips_repository.dart';
import '../data/repositories/trips_repository_impl.dart';
import '../models/destination_model.dart';
import '../models/trip_package_model.dart';

/// Controller managing a single destination guide and its available trip packages
class DestinationController extends GetxController {
  final TripsRepository repository;
  final DestinationModel? initialDestination;
  final String destinationId;

  DestinationController({
    required this.destinationId,
    this.initialDestination,
    TripsRepository? repository,
  }) : repository = repository ?? TripsRepositoryImpl();

  final Rx<ViewState> state = ViewState.initial.obs;
  final Rxn<DestinationModel> destination = Rxn<DestinationModel>();
  final RxList<TripPackageModel> packages = <TripPackageModel>[].obs;
  final RxInt activeTabIndex = 0.obs; // 0: Packages, 1: Overview & Highlights, 2: When to Visit

  @override
  void onInit() {
    super.onInit();
    if (initialDestination != null) {
      destination.value = initialDestination;
    }
    loadDestinationDetails();
  }

  Future<void> loadDestinationDetails() async {
    try {
      state.value = ViewState.loading;

      final destFuture = destination.value != null
          ? Future.value(destination.value)
          : repository.getDestinationById(destinationId);

      final results = await Future.wait([
        destFuture,
        repository.getPackagesByDestination(destinationId),
      ]);

      destination.value = results[0] as DestinationModel?;
      packages.assignAll(results[1] as List<TripPackageModel>);

      state.value = destination.value != null ? ViewState.loaded : ViewState.error;
    } catch (_) {
      state.value = ViewState.error;
    }
  }

  void setActiveTab(int index) {
    activeTabIndex.value = index;
  }
}

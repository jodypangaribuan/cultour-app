import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../shared/widgets/attraction_card.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const GetFeaturedAttractionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildWelcomeSection(),
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/cultour-logo.png',
          height: ResponsiveUtils.getResponsiveHeight(
            context,
            mobile: 100,
            tablet: 120,
            desktop: 140,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang!',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xxl),
                ),
          ),
          SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs)),
          Text(
            'Jelajahi keindahan Indonesia dengan Cultour',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      color: AppColors.backgroundLight,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: AppDimensions.iconXL,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(const GetFeaturedAttractionsEvent());
                    },
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                    vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Destinasi Populer',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Lihat semua akan segera hadir!'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.responsiveCrossAxisCount(mobile: 2, tablet: 3, desktop: 4),
                        crossAxisSpacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                        mainAxisSpacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                        childAspectRatio: context.isMobile ? 0.85 : (context.isTablet ? 0.9 : 1.0),
                      ),
                      itemCount: state.attractions.length,
                      itemBuilder: (context, index) {
                        final attraction = state.attractions[index];
                        return AttractionCard(
                          attraction: attraction,
                          onTap: () {
                            _showAttractionDetails(attraction);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showAttractionDetails(attraction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: ResponsiveUtils.getModalHeight(context),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.l),
            ),
            topRight: Radius.circular(
              AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.l),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ResponsiveUtils.getResponsiveWidth(context, mobile: 40, tablet: 50, desktop: 60),
                height: ResponsiveUtils.getResponsiveHeight(context, mobile: 4, tablet: 5, desktop: 6),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.s) / 4,
                  ),
                ),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 - 
                      ResponsiveUtils.getResponsiveWidth(context, mobile: 20, tablet: 25, desktop: 30),
                  bottom: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                ),
              ),
              Text(
                attraction.name,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                ),
              ),
              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.s),
                  ),
                  SizedBox(width: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs)),
                  Text(
                    attraction.rating.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m)),
              Text(
                attraction.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
                ),
              ),
              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m)),
              Wrap(
                spacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                children: attraction.categories
                    .map(
                      (category) => Chip(
                        label: Text(category),
                        backgroundColor: AppColors.primaryLight,
                        labelStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

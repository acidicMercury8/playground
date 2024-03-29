﻿// This file was auto-generated by ML.NET Model Builder.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers.LightGbm;
using Microsoft.ML.Trainers;
using Microsoft.ML.Transforms;
using Microsoft.ML;

namespace TaxiFare_WebApi
{
    public partial class Prediction
    {
        /// <summary>
        /// Retrains model using the pipeline generated as part of the training process. For more information on how to load data, see aka.ms/loaddata.
        /// </summary>
        /// <param name="mlContext"></param>
        /// <param name="trainData"></param>
        /// <returns></returns>
        public static ITransformer RetrainPipeline(MLContext mlContext, IDataView trainData)
        {
            var pipeline = BuildPipeline(mlContext);
            var model = pipeline.Fit(trainData);

            return model;
        }

        /// <summary>
        /// build the pipeline that is used from model builder. Use this function to retrain model.
        /// </summary>
        /// <param name="mlContext"></param>
        /// <returns></returns>
        public static IEstimator<ITransformer> BuildPipeline(MLContext mlContext)
        {
            // Data process configuration with pipeline data transformations
            var pipeline = mlContext.Transforms.Categorical.OneHotEncoding(new []{new InputOutputColumnPair(@"vendor_id", @"vendor_id"),new InputOutputColumnPair(@"payment_type", @"payment_type")}, outputKind: OneHotEncodingEstimator.OutputKind.Indicator)      
                                    .Append(mlContext.Transforms.ReplaceMissingValues(new []{new InputOutputColumnPair(@"rate_code", @"rate_code"),new InputOutputColumnPair(@"passenger_count", @"passenger_count"),new InputOutputColumnPair(@"trip_distance", @"trip_distance")}))      
                                    .Append(mlContext.Transforms.Concatenate(@"Features", new []{@"vendor_id",@"payment_type",@"rate_code",@"passenger_count",@"trip_distance"}))      
                                    .Append(mlContext.Regression.Trainers.LightGbm(new LightGbmRegressionTrainer.Options(){NumberOfLeaves=2920,NumberOfIterations=4,MinimumExampleCountPerLeaf=20,LearningRate=0.774631950681441,LabelColumnName=@"fare_amount",FeatureColumnName=@"Features",ExampleWeightColumnName=null,Booster=new GradientBooster.Options(){SubsampleFraction=0.999999776672986,FeatureFraction=0.99999999,L1Regularization=2E-10,L2Regularization=0.857638549563097},MaximumBinCountPerFeature=479}));

            return pipeline;
        }
    }
}

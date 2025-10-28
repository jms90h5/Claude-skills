/* begin_generated_IBM_Teracloud_ApS_copyright_prolog               */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* **************************************************************** */
/* THIS SAMPLE CODE IS PROVIDED ON AN "AS IS" BASIS.                */
/* TERACLOUD APS AND IBM MAKES NO REPRESENTATIONS OR WARRANTIES,    */
/* EXPRESS OR IMPLIED, CONCERNING  USE OF THE SAMPLE CODE, OR THE   */
/* COMPLETENESS OR ACCURACY OF THE SAMPLE CODE. TERACLOUD APS       */
/* AND IBM DOES NOT WARRANT UNINTERRUPTED OR ERROR-FREE OPERATION   */
/* OF THIS SAMPLE CODE. TERACLOUD APS AND IBM IS NOT RESPONSIBLE FOR THE */
/* RESULTS OBTAINED FROM THE USE OF THE SAMPLE CODE OR ANY PORTION  */
/* OF THIS SAMPLE CODE.                                             */
/*                                                                  */
/* LIMITATION OF LIABILITY. IN NO EVENT WILL IBM BE LIABLE TO ANY   */
/* PARTY FOR ANY DIRECT, INDIRECT, SPECIAL OR OTHER CONSEQUENTIAL   */
/* DAMAGES FOR ANY USE OF THIS SAMPLE CODE, THE USE OF CODE FROM    */
/* THIS [ SAMPLE PACKAGE,] INCLUDING, WITHOUT LIMITATION, ANY LOST  */
/* PROFITS, BUSINESS INTERRUPTION, LOSS OF PROGRAMS OR OTHER DATA   */
/* ON YOUR INFORMATION HANDLING SYSTEM OR OTHERWISE.                */
/*                                                                  */
/* (C) Copyright Teracloud ApS 2024, 2025, IBM Corp. 2023, 2023     */
/* All Rights reserved.                                             */
/*                                                                  */
/* end_generated_IBM_Teracloud_ApS_copyright_prolog                 */
import java.io.IOException;
import java.util.List;

import com.ibm.research.st.STException;
import com.ibm.research.st.algorithms.hashing.eg.GeoHashEG;
import com.ibm.research.st.datamodel.geometry.ellipsoidal.IBoundingBoxEG;
import com.ibm.research.st.datamodel.geometry.ellipsoidal.IGeometryEG;
import com.ibm.research.st.datamodel.geometry.ellipsoidal.IPointEG;
import com.ibm.research.st.datamodel.geometry.ellipsoidal.impl.BoundingBoxEG;
import com.ibm.research.st.datamodel.geometry.ellipsoidal.impl.PointEG;
import com.ibm.research.st.udf.SpatialUDF;
import com.ibm.research.st.util.BitVector;


public class Sample {

	public static void main(String[] args) throws STException, IOException {
		
		//Goal: to map the whole world by drawing polygons for each geohash.
		String geohashes[] = {"0","1","2","3","4","5","6","7","8","9","b","c","d","e","f","g","h","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z",};
		for (String g : geohashes ) {
			//g = "f"+g;
			GeoHashEG hash = GeoHashEG.getInstance();
		IGeometryEG bbox = hash.geohashStringDecode(g);
			IPointEG lowerCorner = ((BoundingBoxEG)bbox).getLowerCorner();
			IPointEG upperCorner = ((BoundingBoxEG)bbox).getUpperCorner();
			StringBuilder builder = new StringBuilder("POLYGON((");
			builder.append(lowerCorner.getLongitude()).append(" ").append(lowerCorner.getLatitude());
			builder.append(",").append(upperCorner.getLongitude()).append(" ").append(lowerCorner.getLatitude());
			builder.append(",").append(upperCorner.getLongitude()).append(" " ).append(upperCorner.getLatitude());
			builder.append(",").append(lowerCorner.getLongitude()).append(" " ).append(upperCorner.getLatitude());
			builder.append(", ").append(lowerCorner.getLongitude()).append(" ").append(lowerCorner.getLatitude()).append("))");
			System.out.print(",\"" + g + "\", \"" + builder.toString()+ "\"" );
			
			}
		}
	}

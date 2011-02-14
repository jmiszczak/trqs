(* ::Package:: *)

(* ::Section:: *)
(*Header*)


(* File: QI.m *)
(* Description: Mathematica package for generating truly random quantum states using quantum random number generator *)
(* Author: Jaroslaw Miszczak <miszczak@iitis.pl> *)
(* Version: 0.0.5 (13/02/2011) *)
(* License: GPLv3 *)


BeginPackage["TRQS`"];


Begin["`Private`"];


trqsVersion = "0.0.5";


trqsLastModification = "February 13, 2011";


trqsHistory = {
	{"0.0.1", "10/01/2011", "Jarek", "Initial version."},
	{"0.0.2", "31/01/2011", "Jarek", "Some cleanups in functions."},
	{"0.0.3", "06/02/2011", "Jarek", "External functions for integer numbers."},
	{"0.0.4", "07/02/2011", "Jarek", "External functions for double numbers. normal distribution."},
	{"0.0.5", "13/02/2011", "Jarek", "Some configuration related functions."}
};


trqsNames = {"TrueRandomInteger", "TrueRandomReal", "TrueRandomRealNormal", "TrueGinibreMatrix", "TrueRandomSimplex"};
trqsNames = Append[trqsNames, {"TrueRandomKet", "TrueRandomUnitary"}];
trqsNames = Append[trqsNames, {"TrueRandomStateHS", "TrueRandomStateBures"}];
trqsNames = Append[trqsNames, {"QuantisGetLibVersion", "QuantisGetSerialNumber", "QuantisGetDeviceId", "QuantisGetDeviceType"}];
trqsNames = Flatten[trqsNames];


trqsHomeDirectory = DirectoryName[FindFile["TRQS.m"]];


trqsBackend = "TRQS_Quantis";


trqsBinaries = ToString[trqsHomeDirectory<>trqsBackend];


End[];


Print["Package TRQS version ", TRQS`Private`trqsVersion, " (last modification: ", TRQS`Private`trqsLastModification, ")."];


Unprotect@@TRQS`Private`trqsNames;
Clear@@TRQS`Private`trqsNames;


(* ::Section:: *)
(*Public interface*)


(* ::Subsection:: *)
(*Basic functions*)


TrueRandomInteger::usage = "TrueRandomInteger[{i_min,i_max}] returns a random integer in the range [i_min,i_max].";
TrueRandomInteger::usage = TrueRandomInteger::usage <> "\nTrueRandomInteger[i] returns a random integer in the range [0,i].";
TrueRandomInteger::usage = TrueRandomInteger::usage <> "\nTrueRandomInteger[] returns 0 or 1.";


TrueRandomReal::usage = "TrueRandomReal[{x_min,x_max}] returns a random double in the range [x_min,x_max].";
TrueRandomReal::usage = TrueRandomReal::usage <> "\nTrueRandomReal[i] returns a random double in the range [0,x].";
TrueRandomReal::usage = TrueRandomReal::usage <> "\nTrueRandomReal[] returns a random double in the range [0,1].";


TrueRandomRealNormal::usage = "TrueRandomRealNormal[m,s,dims] provides a sample of random numbers distributed according to the normal distribution N[m,s] in an array of dimensions given by dims. Random numbers are obtained using quantum random number generator.";


TrueGinibreMatrix::usage = "TrueGinibreMatrix[n] returns n-dimesnional complex matrix with entries having real and complex part distributed according to the normal distribution N[0,1]. Random numbers used in this functions are obtained from the quantum random numbers generator.";


TrueRandomSimplex::usage = "";


(* ::Subsection:: *)
(*Pure states*)


TrueRandomKet::usage = "TrueRandomKet[d] returns d-dimensional a random pure state represented as a state vector. Random numbers used in this functions are obtained from the quantum random numbers generator.";


TrueRandomUnitary::usage = "";


(* ::Subsection:: *)
(*Mixed states*)


TrueRandomStateHS::usage = "TrueRandomStateHS[d]";


TrueRandomStateBures::usage = "TrueRandomStateBures[d]";


(* ::Subsection:: *)
(*Configuration related functions*)


QuantisGetLibVersion::usage = "QuantisGetLibVersion[] returns a version number of an installed libQuantis library.";


QuantisGetSerialNumber::usage = "QuantisGetSerialNumber[] returns a serial number of the Quantis device used as an backed.";


QuantisGetDeviceId::usage = "QuantisGetDeviceId[] returns an id number of the used Quantis device.";


QuantisGetDeviceType::usage = "QuantisGetDeviceType[] returns a type of the used Quantis device.";


(* ::Section:: *)
(*Private definitions*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Basic functions*)


Install[trqsBinaries<>"/quantis_random_integer"];
Install[trqsBinaries<>"/quantis_random_integer_1"];
Install[trqsBinaries<>"/quantis_random_integer_0"];


Install[trqsBinaries<>"/quantis_random_double"];
Install[trqsBinaries<>"/quantis_random_double_1"];
Install[trqsBinaries<>"/quantis_random_double_0"];


TrueRandomRealNormal[m_,s_,dims_]:=FlattenAt[Fold[Partition[#1,#2]&,m+Sqrt[2]s InverseErf[-1+2 Table[TrueRandomReal[],{Times@@dims}]],Reverse[dims]],1];


TrueGinibreMatrix[m_,n_]:=TrueRandomRealNormal[0,1,{m,n}] + I TrueRandomRealNormal[0,1,{m,n}];


TrueRandomSimplex[d_]:=Block[{r,r1,r2},
	r=Sort[Table[TrueRandomReal[{0,1}],{i,1,d-1}]];
	r1=Append[r,1];
    r2=Prepend[r,0];r1-r2
];


TrueRandomUnitary[dim_]:=Module[{z,q,r,d,ph},
	z=TrueGinibreMatrix[dim,dim];
	{q,r}=QRDecomposition[z];
	d=Diagonal[r];
	ph=d/Abs[d];
	q=q.DiagonalMatrix[ph];
	q
]


(* ::Subsection::Closed:: *)
(*Pure states*)


TrueRandomKet[n_]:=Block[{p,ph},
	p=Sqrt[TrueRandomSimplex[n]];
	ph=Exp[I TrueRandomReal[{0,2\[Pi]},n-1]];
	ph=Prepend[ph,1];
	p*ph
];


(* ::Subsection:: *)
(*Mixed states*)


TrueRandomStateHS[d_]:=Block[{A},
	A=TrueGinibreMatrix[d,d];
	A=(A.ConjugateTranspose[A]);
	A=Chop[A/Tr[A]]
];


TrueRandomStateBures[d_]:=Block[{A,U,X},
	A=TrueGinibreMatrix[d,d];
	U=TrueRandomUnitary[d];
	X=(IdentityMatrix[d]+U).A.A\[ConjugateTranspose].(IdentityMatrix[d]+U)\[ConjugateTranspose];
	Chop[X/Tr[X]]
];


(* ::Subsection:: *)
(*Configuration related functions*)


Install[trqsBinaries<>"/quantis_get_lib_version"];
Install[trqsBinaries<>"/quantis_get_serial_number"];
Install[trqsBinaries<>"/quantis_get_device_id"];
Install[trqsBinaries<>"/quantis_get_device_type"];


End[];


(* ::Subsection:: *)
(*Footer*)


Protect@@TRQS`Private`trqsNames;


EndPackage[];

// // codeunit 50000 "Fleet Management"
// // {
// //     Permissions = tabledata "ADT Requisition Header" = rm,
// //                       tabledata "ADT Requisition Line" = rm,
// //                       tabledata "Email Related Attachment" = rm,
// //                       tabledata "Vendor Ledger Entry" = rm,
// //                       tabledata "Approval Entry" = rimd;
// //     trigger OnRun()
// //     begin

// //     end;

// //     var
// //         Text0001: Label 'There is not enough space to insert extended text lines.';
// //         GLAcc: Record "G/L Account";
// //         Items: Record Item;
// //         Res: Record Resource;
// //         TmpExtTextLine: Record "Extended Text Line" temporary;
// //         NextLineNo: Integer;
// //         LineSpacing: Integer;
// //         MakeUpdateRequired: Boolean;
// //         AutoText: Boolean;

// //         Text000: Label 'Firm Planned %1';
// //         Text001: Label 'Released %1';
// //         Text003: Label 'CU99000845: CalculateRemainingQty - Source type missing';
// //         Text004: Label 'Codeunit 99000845: Illegal FieldFilter parameter';
// //         Text006: Label 'Outbound,Inbound';
// //         Text007: Label 'CU99000845 DeleteReserveEntries2: Surplus order tracking double record detected.';
// //         CalcReservEntry: Record "Reservation Entry";
// //         CalcReservEntry2: Record "Reservation Entry";
// //         ForItemLedgEntry: Record "Item Ledger Entry";
// //         CalcItemLedgEntry: Record "Item Ledger Entry";
// //         ForSalesLine: Record "Sales Line";
// //         CalcSalesLine: Record "Sales Line";
// //         ForPurchLine: Record "Purchase Line";
// //         CalcPurchLine: Record "Purchase Line";
// //         ForItemJnlLine: Record "Item Journal Line";
// //         ForReqLine: Record "Requisition Line";
// //         CalcReqLine: Record "Requisition Line";
// //         ForProdOrderLine: Record "Prod. Order Line";
// //         CalcProdOrderLine: Record "Prod. Order Line";
// //         ForProdOrderComp: Record "Prod. Order Component";
// //         CalcProdOrderComp: Record "Prod. Order Component";
// //         ForPlanningComponent: Record "Planning Component";
// //         CalcPlanningComponent: Record "Planning Component";
// //         ForAssemblyHeader: Record "Assembly Header";
// //         CalcAssemblyHeader: Record "Assembly Header";
// //         ForAssemblyLine: Record "Assembly Line";
// //         CalcAssemblyLine: Record "Assembly Line";
// //         ForTransLine: Record "Transfer Line";
// //         CalcTransLine: Record "Transfer Line";
// //         ForServiceLine: Record "Service Line";
// //         CalcServiceLine: Record "Service Line";
// //         ForJobPlanningLine: Record "Job Planning Line";
// //         CalcJobPlanningLine: Record "Job Planning Line";
// //         ActionMessageEntry: Record "Action Message Entry";
// //         Item: Record "Item";
// //         Location: Record "Location";
// //         MfgSetup: Record "Manufacturing Setup";
// //         SKU: Record "Stockkeeping Unit";
// //         ItemTrackingCode: Record "Item Tracking Code";
// //         TempTrackingSpecification: Record "Tracking Specification" temporary;
// //         CallTrackingSpecification: Record "Tracking Specification";
// //         ForJobJnlLine: Record "Job Journal Line";
// //         CreateReservEntry: Codeunit "Create Reserv. Entry";
// //         ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
// //         ReserveSalesLine: Codeunit "Sales Line-Reserve";
// //         ReserveReqLine: Codeunit "Req. Line-Reserve";
// //         ReservePurchLine: Codeunit "Purch. Line-Reserve";
// //         ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
// //         ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
// //         ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
// //         AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
// //         AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
// //         ReservePlanningComponent: Codeunit "Plng. Component-Reserve";
// //         ReserveServiceInvLine: Codeunit "Service Line-Reserve";
// //         ReserveTransLine: Codeunit "Transfer Line-Reserve";
// //         JobPlanningLineReserve: Codeunit "Job Planning Line-Reserve";
// //         GetPlanningParameters: Codeunit "Planning-Get Parameters";
// //         CreatePick: Codeunit "Create Pick";
// //         Positive: Boolean;
// //         CurrentBindingIsSet: Boolean;
// //         HandleItemTracking: Boolean;
// //         InvSearch: Text[1];
// //         FieldFilter: Text[80];
// //         InvNextStep: Integer;
// //         ValueArray: array[18] of Integer;
// //         CurrentBinding: Option "Order-to-Order";
// //         ItemTrackingHandling: Option "None","Allow deletion",Match;
// //         Text008: Label 'Item tracking defined for item %1 in the %2 accounts for more than the quantity you have entered.\You must adjust the existing item tracking and then reenter the new quantity.';
// //         Text009: Label 'Item Tracking cannot be fully matched.\Serial No.: %1, Lot No.: %2, outstanding quantity: %3.';
// //         Text010: Label 'Item tracking is defined for item %1 in the %2.\You must delete the existing item tracking before modifying or deleting the %2.';
// //         TotalAvailQty: Decimal;
// //         QtyAllocInWhse: Decimal;
// //         QtyOnOutBound: Decimal;
// //         Text011: Label 'Item tracking is defined for item %1 in the %2.\Do you want to delete the %2 and the item tracking lines?';
// //         QtyReservedOnPickShip: Decimal;
// //         Text012: Label 'Assembly';
// //         "==CMM==": Integer;
// //         ForNFLReqLine: Record "ADT Requisition Line";
// //         // ReserveNFLReqLine: Codeunit "Req-Line Reserve2";

// //         //=============PurchInfoPaneMgt=================
// //         Vend: Record Vendor;
// //         PurchHeader: Record "ADT Requisition Header";
// //         Text00011: Label 'The Ship-to Address has been changed.';

// //         //Cash Purchase
// //          CashPurchase: Record "Cash Purchase";
// //         //==========================NFL Purch. Price Calc. Mgt.=======================
// //         //============================================================================
// //         GLSetup: Record "General Ledger Setup";
// //         ResCost: Record "Resource Cost";
// //         Currency: Record Currency;
// //         TempPurchPrice: Record "Purchase Price" temporary;
// //         TempPurchLineDisc: Record "Purchase Line Discount" temporary;
// //         ResFindUnitCost: Codeunit "Resource-Find Cost";
// //         LineDiscPerCent: Decimal;
// //         Qty: Decimal;
// //         QtyPerUOM: Decimal;
// //         VATPerCent: Decimal;
// //         PricesInclVAT: Boolean;
// //         VATBusPostingGr: Code[10];
// //         PricesInCurrency: Boolean;
// //         PriceInSKU: Boolean;
// //         CurrencyFactor: Decimal;
// //         ExchRateDate: Date;
// //         FoundPurchPrice: Boolean;
// //         DateCaption: Text[30];
// //         Text020: Label '%1 is less than %2 in the %3.';
// //         Text030: Label 'Cost including VAT cannot be calculated when %1 is %2.';
// //         Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
// //         Text040: Label 'The %1 in the %2 must be same as in the %3.';
// //         RecRef: RecordRef;

// //         //========Approval Workflow Management========
// //         WorkflowManagementPRQ: Codeunit 1501;
// //         WorkflowEventHandlingCustPRQ: Codeunit "Workflow EventHandling Ext";
// //         NoWorkflowEnabledErrPRQ: TextConst ENU = 'No Approval Workflow for the type is enabled';

// //         //========Approval Workflow Management========
// //         WorkflowManagementMR: Codeunit 1501;
// //         WorkflowEventHandlingCustMR: Codeunit "Workflow EventHandling Ext";
// //         NoWorkflowEnabledErrMR: TextConst ENU = 'No Approval Workflow for the type is enabled';

// //         //================form approval===
// //         WorkflowManagementFM: Codeunit 1501;
// //         WorkflowEventHandlingCustFM: Codeunit "Workflow EventHandling Ext";
// //         NoWorkflowEnabledErrFM: TextConst ENU = 'No Approval Workflow for the type is enabled';

// //     /// <summary>
// //     /// EditDimensionSet2.
// //     /// </summary>
// //     /// <param name="DimSetID">Integer.</param>
// //     /// <param name="NewCaption">Text[250].</param>
// //     /// <param name="VAR GlobalDimVal1">Code[20].</param>
// //     /// <param name="VAR GlobalDimVal2">Code[20].</param>
// //     /// <returns>Return value of type Integer.</returns>
// //     procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]): Integer
// //     var
// //         EditDimSetEntries: Page "Edit Dimension Set Entries";
// //         NewDimSetID: Integer;
// //         DimSetEntry: Record "Dimension Set Entry";
// //         dimensionMgt: Codeunit DimensionManagement;
// //     begin
// //         NewDimSetID := DimSetID;
// //         DimSetEntry.RESET;
// //         DimSetEntry.FILTERGROUP(2);
// //         DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
// //         DimSetEntry.FILTERGROUP(0);
// //         EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
// //         EditDimSetEntries.SetFormCaption(NewCaption);
// //         EditDimSetEntries.RUNMODAL;
// //         NewDimSetID := EditDimSetEntries.GetDimensionID;
// //         dimensionMgt.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
// //         DimSetEntry.RESET;
// //         EXIT(NewDimSetID);
// //     end;

// //     /// <summary>
// //     /// TotalControlsUpdateStyle.
// //     /// </summary>
// //     /// <param name="RefreshMessageEnabled">Boolean.</param>
// //     /// <param name="VAR ControlStyle">Text.</param>
// //     /// <param name="VAR RefreshMessageText">Text.</param>
// //     procedure TotalControlsUpdateStyle(RefreshMessageEnabled: Boolean; VAR ControlStyle: Text; VAR RefreshMessageText: Text)
// //     var
// //         RefreshMsgTxt: TextConst ENU = 'Totals or discounts may not be up-to-date. Choose the link to update.';
// //     begin
// //         IF RefreshMessageEnabled THEN BEGIN
// //             ControlStyle := 'Subordinate';
// //             RefreshMessageText := RefreshMsgTxt;
// //         END ELSE BEGIN
// //             ControlStyle := 'Strong';
// //             RefreshMessageText := '';
// //         END;
// //     end;
// //     //==========================End Document Totals=======================


// //     /// <summary>
// //     /// CreateBookAndOpenExcel.
// //     /// </summary>
// //     /// <param name="SheetName">Text[250].</param>
// //     /// <param name="ReportHeader">Text[80].</param>
// //     /// <param name="CompanyName">Text[30].</param>
// //     /// <param name="UserID2">Text.</param>
// //     procedure CreateBookAndOpenExcel(SheetName: Text[250]; ReportHeader: Text[80]; CompanyName: Text[30]; UserID2: Text)
// //     var
// //         ExcelBuffer: Record "Excel Buffer";
// //     begin
// //         ExcelBuffer.WriteSheet(ReportHeader, CompanyName, UserID2);
// //         ExcelBuffer.CloseBook;
// //         ExcelBuffer.OpenExcel;
// //     end;

// //     /// <summary>
// //     /// TransferQty.
// //     /// </summary>
// //     procedure TransferQty()
// //     var
// //         PurchaseRequisitionLines: Record "ADT Requisition Line";
// //     begin
// //         PurchaseRequisitionLines.Reset();
// //         PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
// //         if PurchaseRequisitionLines.FindFirst() then
// //             repeat
// //                 PurchaseRequisitionLines."Save Qty. to Order" := PurchaseRequisitionLines.Quantity;
// //                 PurchaseRequisitionLines.Modify();
// //             until PurchaseRequisitionLines.Next() = 0;
// //     end;

// //     /// <summary>
// //     /// FillinQtyToOrder.
// //     /// </summary>
// //     procedure FillinQtyToOrder()
// //     var
// //         PurchaseRequisitionLines: Record "ADT Requisition Line";
// //     begin
// //         PurchaseRequisitionLines.Reset();
// //         PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
// //         if PurchaseRequisitionLines.FindFirst() then
// //             repeat
// //                 PurchaseRequisitionLines."Qty. to Order" := PurchaseRequisitionLines."Save Qty. to Order";
// //                 PurchaseRequisitionLines.Modify();
// //             until PurchaseRequisitionLines.Next() = 0;
// //     end;


// //     /// <summary>
// //     /// Description for PurchCheckIfAnyExtText.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <param name="Unconditionally">Parameter of type Boolean.</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure PurchCheckIfAnyExtText(var PurchLine: Record "ADT Requisition Line"; Unconditionally: Boolean): Boolean;
// //     var
// //         PurchHeader: Record "ADT Requisition Header";
// //         ExtTextHeader: Record "Extended Text Header";
// //     begin
// //         MakeUpdateRequired := FALSE;
// //         IF PurchLine."Line No." <> 0 THEN
// //             MakeUpdateRequired := DeletePurchLines(PurchLine);

// //         AutoText := FALSE;

// //         IF Unconditionally THEN
// //             AutoText := TRUE
// //         ELSE
// //             CASE PurchLine.Type OF
// //                 PurchLine.Type::" ":
// //                     AutoText := TRUE;
// //                 PurchLine.Type::"G/L Account":
// //                     BEGIN
// //                         IF GLAcc.GET(PurchLine."No.") THEN
// //                             AutoText := GLAcc."Automatic Ext. Texts";
// //                     END;
// //                 PurchLine.Type::Item:
// //                     BEGIN
// //                         IF Items.GET(PurchLine."No.") THEN
// //                             AutoText := Items."Automatic Ext. Texts";
// //                     END;
// //             END;

// //         IF AutoText THEN BEGIN
// //             PurchLine.TESTFIELD("Document No.");
// //             PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
// //             ExtTextHeader.SETRANGE("Table Name", PurchLine.Type);
// //             ExtTextHeader.SETRANGE("No.", PurchLine."No.");
// //             CASE PurchLine."Document Type" OF
// //                 PurchLine."Document Type"::"Store Requisition":
// //                     ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
// //                 PurchLine."Document Type"::"Purchase Requisition":
// //                     ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
// //             END;
// //             EXIT(ReadLines(ExtTextHeader, PurchHeader."Document Date", PurchHeader."Language Code"));
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for InsertPurchExtText.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     procedure InsertPurchExtText(var PurchLine: Record "ADT Requisition Line");
// //     var
// //         ToPurchLine: Record "ADT Requisition Line";
// //     begin
// //         ToPurchLine.RESET;
// //         ToPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
// //         ToPurchLine.SETRANGE("Document No.", PurchLine."Document No.");
// //         ToPurchLine := PurchLine;
// //         IF ToPurchLine.FIND('>') THEN BEGIN
// //             LineSpacing :=
// //               (ToPurchLine."Line No." - PurchLine."Line No.") DIV
// //               (1 + TmpExtTextLine.COUNT);
// //             IF LineSpacing = 0 THEN
// //                 ERROR(Text0001);
// //         END ELSE
// //             LineSpacing := 10000;

// //         NextLineNo := PurchLine."Line No." + LineSpacing;

// //         TmpExtTextLine.RESET;
// //         IF TmpExtTextLine.FIND('-') THEN BEGIN
// //             REPEAT
// //                 ToPurchLine.INIT;
// //                 ToPurchLine."Document Type" := PurchLine."Document Type";
// //                 ToPurchLine."Document No." := PurchLine."Document No.";
// //                 ToPurchLine."Line No." := NextLineNo;
// //                 NextLineNo := NextLineNo + LineSpacing;
// //                 ToPurchLine.Description := TmpExtTextLine.Text;
// //                 ToPurchLine."Attached to Line No." := PurchLine."Line No.";
// //                 ToPurchLine.INSERT;
// //             UNTIL TmpExtTextLine.NEXT = 0;
// //             MakeUpdateRequired := TRUE;
// //         END;
// //         TmpExtTextLine.DELETEALL;
// //     end;

// //     /// <summary>
// //     /// Description for DeletePurchLines.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure DeletePurchLines(var PurchLine: Record "ADT Requisition Line"): Boolean;
// //     var
// //         PurchLine2: Record "ADT Requisition Line";
// //     begin
// //         PurchLine2.SETRANGE("Document Type", PurchLine."Document Type");
// //         PurchLine2.SETRANGE("Document No.", PurchLine."Document No.");
// //         PurchLine2.SETRANGE("Attached to Line No.", PurchLine."Line No.");
// //         PurchLine2 := PurchLine;
// //         IF PurchLine2.FIND('>') THEN BEGIN
// //             REPEAT
// //                 PurchLine2.DELETE(TRUE);
// //             UNTIL PurchLine2.NEXT = 0;
// //             EXIT(TRUE);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for MakeUpdate.
// //     /// </summary>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure MakeUpdate(): Boolean;
// //     begin
// //         EXIT(MakeUpdateRequired);
// //     end;

// //     /// <summary>
// //     /// Description for ReadLines.
// //     /// </summary>
// //     /// <param name="ExtTextHeader">Parameter of type Record "279".</param>
// //     /// <param name="DocDate">Parameter of type Date.</param>
// //     /// <param name="LanguageCode">Parameter of type Code[10].</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     local procedure ReadLines(var ExtTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]): Boolean;
// //     var
// //         ExtTextLine: Record "Extended Text Line";
// //     begin
// //         ExtTextHeader.SETCURRENTKEY(
// //           "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
// //         ExtTextHeader.SETRANGE("Starting Date", 0D, DocDate);
// //         ExtTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
// //         IF LanguageCode = '' THEN BEGIN
// //             ExtTextHeader.SETRANGE("Language Code", '');
// //             IF NOT ExtTextHeader.FIND('+') THEN
// //                 EXIT;
// //         END ELSE BEGIN
// //             ExtTextHeader.SETRANGE("Language Code", LanguageCode);
// //             IF NOT ExtTextHeader.FIND('+') THEN BEGIN
// //                 ExtTextHeader.SETRANGE("All Language Codes", TRUE);
// //                 ExtTextHeader.SETRANGE("Language Code", '');
// //                 IF NOT ExtTextHeader.FIND('+') THEN
// //                     EXIT;
// //             END;
// //         END;

// //         ExtTextLine.SETRANGE("Table Name", ExtTextHeader."Table Name");
// //         ExtTextLine.SETRANGE("No.", ExtTextHeader."No.");
// //         ExtTextLine.SETRANGE("Language Code", ExtTextHeader."Language Code");
// //         ExtTextLine.SETRANGE("Text No.", ExtTextHeader."Text No.");
// //         IF ExtTextLine.FIND('-') THEN BEGIN
// //             TmpExtTextLine.DELETEALL;
// //             REPEAT
// //                 TmpExtTextLine := ExtTextLine;
// //                 TmpExtTextLine.INSERT;
// //             UNTIL ExtTextLine.NEXT = 0;
// //             EXIT(TRUE);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for SetRequisitionLine.
// //     /// </summary>
// //     /// <param name="NewReqLine">Parameter of type Record "ADT Requisition Line".</param>
// //     procedure SetRequisitionLine(NewReqLine: Record "ADT Requisition Line")
// //     var
// //         CalcReserveEntry: Record "Reservation Entry";
// //         CalcReserveEntry2: Record "Reservation Entry";
// //         ForItemLedgEntry: Record "Item Ledger Entry";
// //         CalcItemLedgEntry: Record "Item Ledger Entry";
// //         ForSalesLine: Record "Sales Line";
// //         CalcSalesLine: Record "Sales Line";
// //         ForPurchLine: Record "Purchase Line";
// //         CalcPurchLine: Record "Purchase Line";
// //         ForItemJnlLine: Record "Item Journal Line";
// //         ForReqLine: Record "Requisition Line";
// //         CalcReqLine: Record "Requisition Line";
// //         ForProdOrderLine: Record "Prod. Order Line";
// //         CalcProdOrderLine: Record "Prod. Order Line";
// //         ForProdOrderComp: Record "Prod. Order Component";
// //         CalcProdOrderComp: Record "Prod. Order Component";
// //         ForPlanningComponent: Record "Planning Component";
// //         CalcPlanningComponent: Record "Planning Component";
// //         ForAssemblyHeader: Record "Assembly Header";
// //         CalcAssemblyHeader: Record "Assembly Header";
// //         ForAssemblyLine: Record "Assembly Line";
// //         CalcAssemblyLine: Record "Assembly Line";
// //         ForTransLine: Record "Transfer Line";
// //         CalcTransLine: Record "Transfer Line";
// //         ForServiceLine: Record "Service Line";
// //         CalcServiceLine: Record "Service Line";
// //         ForJobPlanningLine: Record "Job Planning Line";
// //         CalcJobPlanningLine: Record "Job Planning Line";
// //         ActionMessageEntry: Record "Action Message Entry";
// //         ForNFLReqLine: Record "ADT Requisition Line";
// //         Location: Record Location;
// //         TempTrackingSpecification: Record "Tracking Specification";
// //         ReservationManagement: Codeunit "Reservation Management";
// //     begin
// //         CLEARALL;
// //         TempTrackingSpecification.DELETEALL;

// //         ForNFLReqLine := NewReqLine;

// //         CalcReserveEntry."Source Subtype" := ForNFLReqLine."Document Type";
// //         CalcReserveEntry."Source ID" := NewReqLine."Document No.";
// //         CalcReserveEntry."Source Ref. No." := NewReqLine."Line No.";

// //         IF NewReqLine.Type = NewReqLine.Type::Item THEN
// //             CalcReserveEntry."Item No." := NewReqLine."No.";
// //         CalcReserveEntry."Variant Code" := NewReqLine."Variant Code";
// //         CalcReserveEntry."Location Code" := NewReqLine."Location Code";
// //         CalcReserveEntry."Serial No." := '';
// //         CalcReserveEntry."Lot No." := '';
// //         CalcReserveEntry."Qty. per Unit of Measure" := NewReqLine."Qty. per Unit of Measure";
// //         CalcReserveEntry."Expected Receipt Date" := NewReqLine."Planned Receipt Date";
// //         CalcReserveEntry."Shipment Date" := NewReqLine."Planned Receipt Date";
// //         CalcReserveEntry.Description := NewReqLine.Description;
// //         CalcReserveEntry2 := CalcReserveEntry;
// //         IF (CalcReserveEntry."Location Code" <> '') AND
// //            Location.GET(CalcReserveEntry."Location Code") AND
// //            (Location."Bin Mandatory" OR Location."Require Pick")
// //         THEN;
// //     end;

// //     /// <summary>
// //     /// Description for PurchaseLines.
// //     /// </summary>
// //     /// <param name="PurchaseHeader">Parameter of type Record "Purchase Header".</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure PurchaseLines(PurchaseHeader: Record "Purchase Header"): Boolean;
// //     var
// //         PurchaseLines: Record "Purchase Line";
// //     begin
// //         WITH PurchaseLines DO BEGIN
// //             SETCURRENTKEY("Document Type", "Document No.");
// //             SETRANGE("Document Type", PurchaseHeader."Document Type");
// //             SETRANGE("Document No.", PurchaseHeader."No.");
// //             IF FINDSET THEN
// //                 REPEAT
// //                     IF (Quantity <> 0) AND ("Line Amount" <> 0) THEN
// //                         EXIT(TRUE);
// //                 UNTIL NEXT = 0;
// //         END;
// //         EXIT(FALSE);
// //     end;


// //     //==================================================
// //     //===============PurchInfoPaneMgt==========================

// //     /// <summary>
// //     /// Description for CalcNoOfDocuments.
// //     /// </summary>
// //     /// <param name="Vend">Parameter of type Record Vendor.</param>
// //     procedure CalcNoOfDocuments(var Vend: Record Vendor);
// //     begin
// //         Vend.CALCFIELDS(
// //           "No. of Quotes", "No. of Blanket Orders", "No. of Orders", "No. of Invoices",
// //           "No. of Return Orders", "No. of Credit Memos", "No. of Pstd. Return Shipments", "No. of Pstd. Invoices",
// //           "No. of Pstd. Receipts", "No. of Pstd. Credit Memos",
// //           "Buy-from No. Of Archived Doc.");
// //     end;

// //     /// <summary>
// //     /// Description for CalcTotalNoOfDocuments.
// //     /// </summary>
// //     /// <param name="VendNo">Parameter of type Code[20].</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcTotalNoOfDocuments(VendNo: Code[20]): Integer;
// //     begin
// //         GetVend(VendNo);
// //         WITH Vend DO BEGIN
// //             CalcNoOfDocuments(Vend);
// //             EXIT(
// //               "No. of Quotes" + "No. of Blanket Orders" + "No. of Orders" + "No. of Invoices" +
// //               "No. of Return Orders" + "No. of Credit Memos" +
// //               "No. of Pstd. Receipts" + "No. of Pstd. Invoices" +
// //               "No. of Pstd. Return Shipments" + "No. of Pstd. Credit Memos" +
// //               "Buy-from No. Of Archived Doc.");
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfOrderAddr.
// //     /// </summary>
// //     /// <param name="VendNo">Parameter of type Code[20].</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcNoOfOrderAddr(VendNo: Code[20]): Integer;
// //     begin
// //         GetVend(VendNo);
// //         Vend.CALCFIELDS("No. of Order Addresses");
// //         EXIT(Vend."No. of Order Addresses");
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfContacts.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcNoOfContacts(PurchHeader: Record "ADT Requisition Header"): Integer;
// //     var
// //         Cont: Record Contact;
// //         ContBusRelation: Record "Contact Business Relation";
// //     begin
// //         Cont.SETCURRENTKEY("Company No.");
// //         WITH PurchHeader DO
// //             IF "Buy-from Vendor No." <> '' THEN BEGIN
// //                 IF Cont.GET("Buy-from Contact No.") THEN BEGIN
// //                     Cont.SETRANGE("Company No.", Cont."Company No.");
// //                     EXIT(Cont.COUNT);
// //                 END ELSE BEGIN
// //                     ContBusRelation.RESET;
// //                     ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
// //                     ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
// //                     ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
// //                     IF ContBusRelation.FINDFIRST THEN BEGIN
// //                         Cont.SETRANGE("Company No.", ContBusRelation."Contact No.");
// //                         EXIT(Cont.COUNT);
// //                     END ELSE
// //                         EXIT(0)
// //                 END;
// //             END;
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfSubstitutions.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcNoOfSubstitutions(var PurchLine: Record "ADT Requisition Line"): Integer;
// //     begin
// //         IF GetItem(PurchLine) THEN BEGIN
// //             Item.CALCFIELDS("No. of Substitutes");
// //             EXIT(Item."No. of Substitutes");
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfPurchasePrices.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcNoOfPurchasePrices(var PurchLine: Record "ADT Requisition Line"): Integer;
// //     begin
// //         IF GetItem(PurchLine) THEN BEGIN
// //             GetPurchHeader(PurchLine);
// //             EXIT(NoOfPurchLinePrice(PurchHeader, PurchLine, TRUE));
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfPurchLineDisc.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure CalcNoOfPurchLineDisc(var PurchLine: Record "ADT Requisition Line"): Integer;
// //     begin
// //         IF GetItem(PurchLine) THEN BEGIN
// //             GetPurchHeader(PurchLine);
// //             EXIT(NoOfPurchLineLineDisc(PurchHeader, PurchLine, TRUE));
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for DocExist.
// //     /// </summary>
// //     /// <param name="CurrentPurchHeader">Parameter of type Record "51407290".</param>
// //     /// <param name="VendNo">Parameter of type Code[20].</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure DocExist(CurrentPurchHeader: Record "ADT Requisition Header"; VendNo: Code[20]): Boolean;
// //     var
// //         PurchInvHeader: Record "Purch. Inv. Header";
// //         PurchRcptHeader: Record "Purch. Rcpt. Header";
// //         PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
// //         ReturnShipment: Record "Return Shipment Header";
// //         PurchHeader: Record "ADT Requisition Header";
// //     begin
// //         IF VendNo = '' THEN
// //             EXIT(FALSE);
// //         WITH PurchInvHeader DO BEGIN
// //             SETCURRENTKEY("Buy-from Vendor No.");
// //             SETRANGE("Buy-from Vendor No.", VendNo);
// //             IF NOT ISEMPTY THEN
// //                 EXIT(TRUE);
// //         END;
// //         WITH PurchRcptHeader DO BEGIN
// //             SETCURRENTKEY("Buy-from Vendor No.");
// //             SETRANGE("Buy-from Vendor No.", VendNo);
// //             IF NOT ISEMPTY THEN
// //                 EXIT(TRUE);
// //         END;
// //         WITH PurchCrMemoHeader DO BEGIN
// //             SETCURRENTKEY("Buy-from Vendor No.");
// //             SETRANGE("Buy-from Vendor No.", VendNo);
// //             IF NOT ISEMPTY THEN
// //                 EXIT(TRUE);
// //         END;
// //         WITH PurchHeader DO BEGIN
// //             SETCURRENTKEY("Buy-from Vendor No.");
// //             SETRANGE("Buy-from Vendor No.", VendNo);
// //             IF FINDFIRST THEN BEGIN
// //                 IF ("Document Type" <> CurrentPurchHeader."Document Type") OR
// //                    ("No." <> CurrentPurchHeader."No.")
// //                 THEN
// //                     EXIT(TRUE);
// //                 IF FIND('>') THEN
// //                     EXIT(TRUE);
// //             END;
// //         END;
// //         WITH ReturnShipment DO BEGIN
// //             SETCURRENTKEY("Buy-from Vendor No.");
// //             SETRANGE("Buy-from Vendor No.", VendNo);
// //             IF NOT ISEMPTY THEN
// //                 EXIT(TRUE);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for VendCommentExists.
// //     /// </summary>
// //     /// <param name="VendNo">Parameter of type Code[20].</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure VendCommentExists(VendNo: Code[20]): Boolean;
// //     begin
// //         GetVend(VendNo);
// //         Vend.CALCFIELDS(Comment);
// //         EXIT(Vend.Comment);
// //     end;

// //     /// <summary>
// //     /// Description for ItemCommentExists.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure ItemCommentExists(var PurchLine: Record "ADT Requisition Line"): Boolean;
// //     begin
// //         IF GetItem(PurchLine) THEN BEGIN
// //             Item.CALCFIELDS(Comment);
// //             EXIT(Item.Comment);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for LookupOrderAddr.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     procedure LookupOrderAddr(var PurchHeader: Record "ADT Requisition Header");
// //     var
// //         OrderAddress: Record "Order Address";
// //     begin
// //         WITH PurchHeader DO BEGIN
// //             OrderAddress.SETRANGE("Vendor No.", "Buy-from Vendor No.");
// //             IF PAGE.RUNMODAL(0, OrderAddress) = ACTION::LookupOK THEN BEGIN
// //                 VALIDATE("Order Address Code", OrderAddress.Code);
// //                 MODIFY(TRUE);
// //                 MESSAGE(Text00011);
// //             END;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for LookupContacts.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     procedure LookupContacts(var PurchHeader: Record "ADT Requisition Header");
// //     var
// //         Cont: Record Contact;
// //         ContBusRelation: Record "Contact Business Relation";
// //     begin
// //         WITH PurchHeader DO BEGIN
// //             IF "Buy-from Vendor No." <> '' THEN BEGIN
// //                 IF Cont.GET("Buy-from Contact No.") THEN
// //                     Cont.SETRANGE("Company No.", Cont."Company No.")
// //                 ELSE BEGIN
// //                     ContBusRelation.RESET;
// //                     ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
// //                     ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
// //                     ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
// //                     IF ContBusRelation.FINDFIRST THEN
// //                         Cont.SETRANGE("Company No.", ContBusRelation."Contact No.")
// //                     ELSE
// //                         Cont.SETRANGE("No.", '');
// //                 END;

// //                 IF Cont.GET("Buy-from Contact No.") THEN;
// //             END ELSE
// //                 Cont.SETRANGE("No.", '');
// //             IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
// //                 VALIDATE("Buy-from Contact No.", Cont."No.");
// //                 MODIFY(TRUE);
// //             END;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for LookupItem.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     procedure LookupItem(PurchLine: Record "ADT Requisition Line");
// //     begin
// //         PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
// //         PurchLine.TESTFIELD("No.");
// //         GetItem(PurchLine);
// //         PAGE.RUNMODAL(PAGE::"Item Card", Item);
// //     end;

// //     /// <summary>
// //     /// Description for LookupItemComment.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     procedure LookupItemComment(PurchLine: Record "ADT Requisition Line");
// //     var
// //         CommentLine: Record "Comment Line";
// //     begin
// //         IF GetItem(PurchLine) THEN BEGIN
// //             CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
// //             CommentLine.SETRANGE("No.", PurchLine."No.");
// //             PAGE.RUNMODAL(PAGE::"Comment Sheet", CommentLine);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for GetVend.
// //     /// </summary>
// //     /// <param name="VendNo">Parameter of type Code[20].</param>
// //     local procedure GetVend(VendNo: Code[20]);
// //     begin
// //         IF VendNo <> '' THEN BEGIN
// //             IF VendNo <> Vend."No." THEN
// //                 IF NOT Vend.GET(VendNo) THEN
// //                     CLEAR(Vend);
// //         END ELSE
// //             CLEAR(Vend);
// //     end;

// //     /// <summary>
// //     /// Description for GetItem.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     local procedure GetItem(var PurchLine: Record "ADT Requisition Line"): Boolean;
// //     begin
// //         WITH Item DO BEGIN
// //             IF (PurchLine.Type <> PurchLine.Type::Item) OR (PurchLine."No." = '') THEN
// //                 EXIT(FALSE);

// //             IF PurchLine."No." <> "No." THEN
// //                 GET(PurchLine."No.");
// //             EXIT(TRUE);
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for GetPurchHeader.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     local procedure GetPurchHeader(PurchLine: Record "ADT Requisition Line");
// //     begin
// //         IF (PurchLine."Document Type" <> PurchHeader."Document Type") OR
// //            (PurchLine."Document No." <> PurchHeader."No.")
// //         THEN
// //             PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
// //     end;

// //     /// <summary>
// //     /// Description for CalcNoOfPayToDocuments.
// //     /// </summary>
// //     /// <param name="Vend">Parameter of type Record Vendor.</param>
// //     procedure CalcNoOfPayToDocuments(var Vend: Record Vendor);
// //     begin
// //         Vend.CALCFIELDS(
// //           "Pay-to No. of Quotes", "Pay-to No. of Blanket Orders", "Pay-to No. of Orders", "Pay-to No. of Invoices",
// //           "Pay-to No. of Return Orders", "Pay-to No. of Credit Memos", "Pay-to No. of Pstd. Receipts",
// //           "Pay-to No. of Pstd. Invoices", "Pay-to No. of Pstd. Return S.", "Pay-to No. of Pstd. Cr. Memos",
// //           "Pay-to No. Of Archived Doc.");
// //     end;

// //     /// <summary>
// //     /// Description for CalcAvailability2.
// //     /// </summary>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <returns>Return variable "Decimal".</returns>
// //     procedure CalcAvailability2(var PurchLine: Record "ADT Requisition Line"): Decimal;
// //     var
// //         AvailableToPromise: Codeunit "Available to Promise";
// //         GrossRequirement: Decimal;
// //         ScheduledReceipt: Decimal;
// //         PeriodType: Option Day,Week,Month,Quarter,Year;
// //         AvailabilityDate: Date;
// //         LookaheadDateFormula: DateFormula;
// //         lvItemLedgEntry: Record "Item Ledger Entry";
// //         lvInvtQty: Decimal;
// //         lvReservEntry: Record "Reservation Entry";
// //         lvReservedQty: Decimal;
// //     begin
// //         lvInvtQty := 0;
// //         IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
// //             lvItemLedgEntry.RESET;
// //             lvItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
// //             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Item No.", PurchLine."No.");
// //             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Variant Code", PurchLine."Variant Code");
// //             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Location Code", PurchLine."Location Code");
// //             lvItemLedgEntry.CALCSUMS(lvItemLedgEntry.Quantity);
// //             lvInvtQty := lvItemLedgEntry.Quantity;

// //             //get reserved quantity
// //             lvReservEntry.SETCURRENTKEY("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code");
// //             lvReservEntry.SETRANGE(lvReservEntry."Item No.", PurchLine."No.");
// //             lvReservEntry.SETFILTER(lvReservEntry."Source Type", '%1', 32);
// //             lvReservEntry.SETFILTER(lvReservEntry."Source Subtype", '%1', 0);
// //             lvReservEntry.SETFILTER(lvReservEntry."Reservation Status", '%1', lvReservEntry."Reservation Status"::Reservation);
// //             lvReservEntry.SETRANGE(lvReservEntry."Location Code", PurchLine."Location Code");
// //             lvReservEntry.SETRANGE(lvReservEntry."Variant Code", PurchLine."Variant Code");
// //             lvReservEntry.CALCSUMS(lvReservEntry."Quantity (Base)");
// //             lvReservedQty := lvReservEntry."Quantity (Base)";
// //             EXIT(lvInvtQty - lvReservedQty);
// //         END
// //         ELSE
// //             EXIT(lvInvtQty);
// //     end;


// //     //==================================================================
// //     //===================NFL Purch. Price Calc. Mgt.====================

// //     /// <summary>
// //     /// Description for FindPurchLinePrice.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <param name="CalledByFieldNo">Parameter of type Integer.</param>
// //     procedure FindPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; CalledByFieldNo: Integer);
// //     begin
// //         WITH PurchLine DO BEGIN
// //             SetCurrency(
// //               PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));
// //             SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
// //             SetLineDisc("Line Discount %");

// //             TESTFIELD("Qty. per Unit of Measure");
// //             IF PricesInCurrency THEN
// //                 PurchHeader.TESTFIELD("Currency Factor");

// //             CASE Type OF
// //                 Type::Item:
// //                     BEGIN
// //                         Item.GET("No.");
// //                         PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

// //                         PurchLinePriceExists(PurchHeader, PurchLine, FALSE);
// //                         CalcBestDirectUnitCost(TempPurchPrice);

// //                         IF FoundPurchPrice OR
// //                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //                         THEN
// //                             "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
// //                     END;
// //             END;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for FindItemJnlLinePrice.
// //     /// </summary>
// //     /// <param name="ItemJnlLine">Parameter of type Record "Item Journal Line".</param>
// //     /// <param name="CalledByFieldNo">Parameter of type Integer.</param>
// //     procedure FindItemJnlLinePrice(var ItemJnlLine: Record "Item Journal Line"; CalledByFieldNo: Integer);
// //     begin
// //         WITH ItemJnlLine DO BEGIN
// //             TESTFIELD("Qty. per Unit of Measure");
// //             SetCurrency('', 0, 0D);
// //             SetVAT(FALSE, 0, '');
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             Item.GET("Item No.");
// //             PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

// //             FindPurchPrice(
// //               TempPurchPrice, '', "Item No.", "Variant Code",
// //               "Unit of Measure Code", '', "Posting Date", FALSE);
// //             CalcBestDirectUnitCost(TempPurchPrice);

// //             IF FoundPurchPrice OR
// //                NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                     (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //             THEN
// //                 "Unit Amount" := TempPurchPrice."Direct Unit Cost";
// //         END;
// //     end;

// //     procedure FindReqLinePrice(var ReqLine: Record "Requisition Line"; CalledByFieldNo: Integer);
// //     begin
// //         WITH ReqLine DO BEGIN
// //             IF Type = Type::Item THEN BEGIN
// //                 IF NOT Vend.GET("Vendor No.") THEN
// //                     Vend.INIT;

// //                 SetCurrency("Currency Code", "Currency Factor", "Order Date");
// //                 SetVAT(Vend."Prices Including VAT", 0, '');
// //                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //                 TESTFIELD("Qty. per Unit of Measure");
// //                 IF PricesInCurrency THEN
// //                     ReqLine.TESTFIELD("Currency Factor");

// //                 Item.GET("No.");
// //                 PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

// //                 FindPurchPrice(
// //                   TempPurchPrice, "Vendor No.", "No.", "Variant Code",
// //                   "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
// //                 CalcBestDirectUnitCost(TempPurchPrice);

// //                 IF FoundPurchPrice OR
// //                    NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                         (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //                 THEN
// //                     "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
// //             END;
// //         END;
// //     end;

// //     procedure FindPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
// //     begin
// //         WITH PurchLine DO BEGIN
// //             SetCurrency(PurchHeader."Currency Code", 0, 0D);
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             TESTFIELD("Qty. per Unit of Measure");

// //             IF PurchLine.Type = Type::Item THEN BEGIN
// //                 PurchLineLineDiscExists(PurchHeader, PurchLine, FALSE);
// //                 CalcBestLineDisc(TempPurchLineDisc);

// //                 "Line Discount %" := TempPurchLineDisc."Line Discount %";
// //             END;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for FindStdItemJnlLinePrice.
// //     /// </summary>
// //     /// <param name="StdItemJnlLine">Parameter of type Record "Standard Item Journal Line".</param>
// //     /// <param name="CalledByFieldNo">Parameter of type Integer.</param>
// //     procedure FindStdItemJnlLinePrice(var StdItemJnlLine: Record "Standard Item Journal Line"; CalledByFieldNo: Integer);
// //     begin
// //         WITH StdItemJnlLine DO BEGIN
// //             TESTFIELD("Qty. per Unit of Measure");
// //             SetCurrency('', 0, 0D);
// //             SetVAT(FALSE, 0, '');
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             Item.GET("Item No.");
// //             PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

// //             FindPurchPrice(
// //               TempPurchPrice, '', "Item No.", "Variant Code",
// //               "Unit of Measure Code", '', WORKDATE, FALSE);
// //             CalcBestDirectUnitCost(TempPurchPrice);

// //             IF FoundPurchPrice OR
// //                NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                     (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //             THEN
// //                 "Unit Amount" := TempPurchPrice."Direct Unit Cost";
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for FindReqLineDisc.
// //     /// </summary>
// //     /// <param name="ReqLine">Parameter of type Record "Requisition Line".</param>
// //     procedure FindReqLineDisc(var ReqLine: Record "Requisition Line");
// //     begin
// //         WITH ReqLine DO BEGIN
// //             SetCurrency("Currency Code", 0, 0D);
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             TESTFIELD("Qty. per Unit of Measure");

// //             IF ReqLine.Type = Type::Item THEN BEGIN

// //                 FindPurchLineDisc(
// //                   TempPurchLineDisc, "Vendor No.", "No.", "Variant Code",
// //                   "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
// //                 CalcBestLineDisc(TempPurchLineDisc);

// //                 "Line Discount %" := TempPurchLineDisc."Line Discount %";
// //             END;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for CalcBestDirectUnitCost.
// //     /// </summary>
// //     /// <param name="PurchPrice">Parameter of type Record "7012".</param>
// //     local procedure CalcBestDirectUnitCost(var PurchPrice: Record "Purchase Price");
// //     var
// //         BestPurchPrice: Record "Purchase Price";
// //     begin
// //         WITH PurchPrice DO BEGIN
// //             FoundPurchPrice := PurchPrice.FIND('-');
// //             IF FoundPurchPrice THEN
// //                 REPEAT
// //                     IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
// //                         ConvertPriceToVAT(
// //                           Vend."Prices Including VAT", Item."VAT Prod. Posting Group",
// //                           Vend."VAT Bus. Posting Group", "Direct Unit Cost");
// //                         ConvertPriceToUoM("Unit of Measure Code", "Direct Unit Cost");
// //                         ConvertPriceLCYToFCY("Currency Code", "Direct Unit Cost");

// //                         CASE TRUE OF
// //                             ((BestPurchPrice."Currency Code" = '') AND ("Currency Code" <> '')) OR
// //                           ((BestPurchPrice."Variant Code" = '') AND ("Variant Code" <> '')):
// //                                 BestPurchPrice := PurchPrice;
// //                             ((BestPurchPrice."Currency Code" = '') OR ("Currency Code" <> '')) AND
// //                           ((BestPurchPrice."Variant Code" = '') OR ("Variant Code" <> '')):
// //                                 IF (BestPurchPrice."Direct Unit Cost" = 0) OR
// //                                    (CalcLineAmount(BestPurchPrice) > CalcLineAmount(PurchPrice))
// //                                 THEN
// //                                     BestPurchPrice := PurchPrice;
// //                         END;
// //                     END;
// //                 UNTIL NEXT = 0;
// //         END;

// //         // No price found in agreement
// //         IF BestPurchPrice."Direct Unit Cost" = 0 THEN BEGIN
// //             PriceInSKU := PriceInSKU AND (SKU."Last Direct Cost" <> 0);
// //             IF PriceInSKU THEN
// //                 BestPurchPrice."Direct Unit Cost" := SKU."Last Direct Cost"
// //             ELSE
// //                 BestPurchPrice."Direct Unit Cost" := Item."Last Direct Cost";

// //             ConvertPriceToVAT(FALSE, Item."VAT Prod. Posting Group", '', BestPurchPrice."Direct Unit Cost");
// //             ConvertPriceToUoM('', BestPurchPrice."Direct Unit Cost");
// //             ConvertPriceLCYToFCY('', BestPurchPrice."Direct Unit Cost");
// //         END;

// //         PurchPrice := BestPurchPrice;
// //     end;

// //     local procedure CalcBestLineDisc(var PurchLineDisc: Record "Purchase Line Discount");
// //     var
// //         BestPurchLineDisc: Record "Purchase Line Discount";
// //     begin
// //         WITH PurchLineDisc DO
// //             IF FIND('-') THEN
// //                 REPEAT
// //                     IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN
// //                         CASE TRUE OF
// //                             ((BestPurchLineDisc."Currency Code" = '') AND ("Currency Code" <> '')) OR
// //                           ((BestPurchLineDisc."Variant Code" = '') AND ("Variant Code" <> '')):
// //                                 BestPurchLineDisc := PurchLineDisc;
// //                             ((BestPurchLineDisc."Currency Code" = '') OR ("Currency Code" <> '')) AND
// //                           ((BestPurchLineDisc."Variant Code" = '') OR ("Variant Code" <> '')):
// //                                 IF BestPurchLineDisc."Line Discount %" < "Line Discount %" THEN
// //                                     BestPurchLineDisc := PurchLineDisc;
// //                         END;
// //                 UNTIL NEXT = 0;

// //         PurchLineDisc := BestPurchLineDisc;
// //     end;

// //     /// <summary>
// //     /// Description for FindPurchPrice.
// //     /// </summary>
// //     /// <param name="ToPurchPrice">Parameter of type Record "7012".</param>
// //     /// <param name="VendorNo">Parameter of type Code[20].</param>
// //     /// <param name="ItemNo">Parameter of type Code[20].</param>
// //     /// <param name="VariantCode">Parameter of type Code[10].</param>
// //     /// <param name="UOM">Parameter of type Code[10].</param>
// //     /// <param name="CurrencyCode">Parameter of type Code[10].</param>
// //     /// <param name="StartingDate">Parameter of type Date.</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     procedure FindPurchPrice(var ToPurchPrice: Record "Purchase Price"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
// //     var
// //         FromPurchPrice: Record "Purchase Price";
// //     begin
// //         WITH FromPurchPrice DO BEGIN
// //             SETRANGE("Item No.", ItemNo);
// //             SETRANGE("Vendor No.", VendorNo);
// //             SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
// //             SETFILTER("Variant Code", '%1|%2', VariantCode, '');
// //             IF NOT ShowAll THEN BEGIN
// //                 SETRANGE("Starting Date", 0D, StartingDate);
// //                 SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
// //                 SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
// //             END;

// //             ToPurchPrice.RESET;
// //             ToPurchPrice.DELETEALL;
// //             IF FromPurchPrice.FIND('-') THEN
// //                 REPEAT
// //                     IF FromPurchPrice."Direct Unit Cost" <> 0 THEN BEGIN
// //                         ToPurchPrice := FromPurchPrice;
// //                         ToPurchPrice.INSERT;
// //                     END;
// //                 UNTIL FromPurchPrice.NEXT = 0;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for FindPurchLineDisc.
// //     /// </summary>
// //     /// <param name="ToPurchLineDisc">Parameter of type Record "Purchase Line Discount".</param>
// //     /// <param name="VendorNo">Parameter of type Code[20].</param>
// //     /// <param name="ItemNo">Parameter of type Code[20].</param>
// //     /// <param name="VariantCode">Parameter of type Code[10].</param>
// //     /// <param name="UOM">Parameter of type Code[10].</param>
// //     /// <param name="CurrencyCode">Parameter of type Code[10].</param>
// //     /// <param name="StartingDate">Parameter of type Date.</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     procedure FindPurchLineDisc(var ToPurchLineDisc: Record "Purchase Line Discount"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
// //     var
// //         FromPurchLineDisc: Record "Purchase Line Discount";
// //     begin
// //         WITH FromPurchLineDisc DO BEGIN
// //             SETRANGE("Item No.", ItemNo);
// //             SETRANGE("Vendor No.", VendorNo);
// //             SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
// //             SETFILTER("Variant Code", '%1|%2', VariantCode, '');
// //             IF NOT ShowAll THEN BEGIN
// //                 SETRANGE("Starting Date", 0D, StartingDate);
// //                 SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
// //                 SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
// //             END;

// //             ToPurchLineDisc.RESET;
// //             ToPurchLineDisc.DELETEALL;

// //             IF FIND('-') THEN
// //                 REPEAT
// //                     IF FromPurchLineDisc."Line Discount %" <> 0 THEN BEGIN
// //                         ToPurchLineDisc := FromPurchLineDisc;
// //                         ToPurchLineDisc.INSERT;
// //                     END;
// //                 UNTIL FromPurchLineDisc.NEXT = 0;
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for SetCurrency.
// //     /// </summary>
// //     /// <param name="CurrencyCode2">Parameter of type Code[10].</param>
// //     /// <param name="CurrencyFactor2">Parameter of type Decimal.</param>
// //     /// <param name="ExchRateDate2">Parameter of type Date.</param>
// //     local procedure SetCurrency(CurrencyCode2: Code[10]; CurrencyFactor2: Decimal; ExchRateDate2: Date);
// //     begin
// //         PricesInCurrency := CurrencyCode2 <> '';
// //         IF PricesInCurrency THEN BEGIN
// //             Currency.GET(CurrencyCode2);
// //             Currency.TESTFIELD("Unit-Amount Rounding Precision");
// //             CurrencyFactor := CurrencyFactor2;
// //             ExchRateDate := ExchRateDate2;
// //         END ELSE
// //             GLSetup.GET;
// //     end;

// //     /// <summary>
// //     /// Description for SetVAT.
// //     /// </summary>
// //     /// <param name="PriceInclVAT2">Parameter of type Boolean.</param>
// //     /// <param name="VATPerCent2">Parameter of type Decimal.</param>
// //     /// <param name="VATBusPostingGr2">Parameter of type Code[10].</param>
// //     local procedure SetVAT(PriceInclVAT2: Boolean; VATPerCent2: Decimal; VATBusPostingGr2: Code[10]);
// //     begin
// //         PricesInclVAT := PriceInclVAT2;
// //         VATPerCent := VATPerCent2;
// //         VATBusPostingGr := VATBusPostingGr2;
// //     end;

// //     /// <summary>
// //     /// Description for SetUoM.
// //     /// </summary>
// //     /// <param name="Qty2">Parameter of type Decimal.</param>
// //     /// <param name="QtyPerUoM2">Parameter of type Decimal.</param>
// //     local procedure SetUoM(Qty2: Decimal; QtyPerUoM2: Decimal);
// //     begin
// //         Qty := Qty2;
// //         QtyPerUOM := QtyPerUoM2;
// //     end;

// //     /// <summary>
// //     /// Description for SetLineDisc.
// //     /// </summary>
// //     /// <param name="LineDiscPerCent2">Parameter of type Decimal.</param>
// //     local procedure SetLineDisc(LineDiscPerCent2: Decimal);
// //     begin
// //         LineDiscPerCent := LineDiscPerCent2;
// //     end;

// //     /// <summary>
// //     /// Description for IsInMinQty.
// //     /// </summary>
// //     /// <param name="UnitOfMeasureCode">Parameter of type Code[10].</param>
// //     /// <param name="MinQty">Parameter of type Decimal.</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     local procedure IsInMinQty(UnitOfMeasureCode: Code[10]; MinQty: Decimal): Boolean;
// //     begin
// //         IF UnitOfMeasureCode = '' THEN
// //             EXIT(MinQty <= QtyPerUOM * Qty);
// //         EXIT(MinQty <= Qty);
// //     end;

// //     /// <summary>
// //     /// Description for ConvertPriceToVAT.
// //     /// </summary>
// //     /// <param name="FromPriceInclVAT">Parameter of type Boolean.</param>
// //     /// <param name="FromVATProdPostingGr">Parameter of type Code[10].</param>
// //     /// <param name="FromVATBusPostingGr">Parameter of type Code[10].</param>
// //     /// <param name="UnitPrice">Parameter of type Decimal.</param>
// //     local procedure ConvertPriceToVAT(FromPriceInclVAT: Boolean; FromVATProdPostingGr: Code[10]; FromVATBusPostingGr: Code[10]; var UnitPrice: Decimal);
// //     var
// //         VATPostingSetup: Record "VAT Posting Setup";
// //     begin
// //         IF FromPriceInclVAT THEN BEGIN
// //             IF NOT VATPostingSetup.GET(FromVATBusPostingGr, FromVATProdPostingGr) THEN
// //                 VATPostingSetup.INIT;

// //             IF PricesInclVAT THEN BEGIN
// //                 IF VATBusPostingGr <> FromVATBusPostingGr THEN
// //                     UnitPrice := UnitPrice * (100 + VATPerCent) / (100 + VATPostingSetup."VAT %");
// //             END ELSE
// //                 UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
// //         END ELSE
// //             IF PricesInclVAT THEN
// //                 UnitPrice := UnitPrice * (1 + VATPerCent / 100);
// //     end;

// //     /// <summary>
// //     /// Description for ConvertPriceToUoM.
// //     /// </summary>
// //     /// <param name="UnitOfMeasureCode">Parameter of type Code[10].</param>
// //     /// <param name="UnitPrice">Parameter of type Decimal.</param>
// //     local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal);
// //     begin
// //         IF UnitOfMeasureCode = '' THEN
// //             UnitPrice := UnitPrice * QtyPerUOM;
// //     end;

// //     /// <summary>
// //     /// Description for ConvertPriceLCYToFCY.
// //     /// </summary>
// //     /// <param name="CurrencyCode">Parameter of type Code[10].</param>
// //     /// <param name="UnitPrice">Parameter of type Decimal.</param>
// //     local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal);
// //     var
// //         CurrExchRate: Record "Currency Exchange Rate";
// //     begin
// //         IF PricesInCurrency THEN BEGIN
// //             IF CurrencyCode = '' THEN
// //                 UnitPrice :=
// //                   CurrExchRate.ExchangeAmtLCYToFCY(ExchRateDate, Currency.Code, UnitPrice, CurrencyFactor);
// //             UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
// //         END ELSE
// //             UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
// //     end;

// //     /// <summary>
// //     /// Description for CalcLineAmount.
// //     /// </summary>
// //     /// <param name="PurchPrice">Parameter of type Record "Purchase Price".</param>
// //     /// <returns>Return variable "Decimal".</returns>
// //     local procedure CalcLineAmount(PurchPrice: Record "Purchase Price"): Decimal;
// //     begin
// //         WITH PurchPrice DO
// //             EXIT("Direct Unit Cost" * (1 - LineDiscPerCent / 100));
// //     end;

// //     /// <summary>
// //     /// Description for PurchLinePriceExists.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     /// <param name="PurchLine">Parameter of type Record "51407291".</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure PurchLinePriceExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
// //     begin
// //         WITH PurchLine DO
// //             IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
// //                 FindPurchPrice(
// //                   TempPurchPrice, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
// //                   PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
// //                 EXIT(TempPurchPrice.FIND('-'));
// //             END;
// //         EXIT(FALSE);
// //     end;

// //     /// <summary>
// //     /// Description for PurchLineLineDiscExists.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     /// <returns>Return variable "Boolean".</returns>
// //     procedure PurchLineLineDiscExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
// //     begin
// //         WITH PurchLine DO
// //             IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
// //                 FindPurchLineDisc(
// //                   TempPurchLineDisc, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
// //                   PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
// //                 EXIT(TempPurchLineDisc.FIND('-'));
// //             END;
// //         EXIT(FALSE);
// //     end;

// //     /// <summary>
// //     /// Description for PurchHeaderExchDate.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     /// <returns>Return variable "Date".</returns>
// //     local procedure PurchHeaderExchDate(PurchHeader: Record "ADT Requisition Header"): Date;
// //     begin
// //         WITH PurchHeader DO BEGIN
// //             IF ("Document Type" IN ["Document Type"::"Store Requisition", "Document Type"::"Purchase Requisition"]) AND
// //                ("Posting Date" = 0D)
// //             THEN
// //                 EXIT(WORKDATE);
// //             EXIT("Posting Date");
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for PurchHeaderStartDate.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "51407290".</param>
// //     /// <param name="DateCaption">Parameter of type Text[30].</param>
// //     /// <returns>Return variable "Date".</returns>
// //     local procedure PurchHeaderStartDate(PurchHeader: Record "ADT Requisition Header"; var DateCaption: Text[30]): Date;
// //     begin
// //         WITH PurchHeader DO BEGIN
// //             DateCaption := FIELDCAPTION("Order Date");
// //             EXIT("Order Date");
// //         END;

// //     end;

// //     /// <summary>
// //     /// Description for FindJobPlanningLinePrice.
// //     /// </summary>
// //     /// <param name="JobPlanningLine">Parameter of type Record "Job Planning Line".</param>
// //     /// <param name="CalledByFieldNo">Parameter of type Integer.</param>
// //     procedure FindJobPlanningLinePrice(var JobPlanningLine: Record "Job Planning Line"; CalledByFieldNo: Integer);
// //     var
// //         JTHeader: Record Job;
// //     begin
// //         WITH JobPlanningLine DO BEGIN
// //             SetCurrency("Currency Code", "Currency Factor", "Planning Date");
// //             SetVAT(FALSE, 0, '');
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             TESTFIELD("Qty. per Unit of Measure");

// //             CASE Type OF
// //                 Type::Item:
// //                     BEGIN
// //                         Item.GET("No.");
// //                         PriceInSKU := SKU.GET('', "No.", "Variant Code");
// //                         JTHeader.GET("Job No.");

// //                         FindPurchPrice(
// //                           TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", '', "Planning Date", FALSE);
// //                         PricesInCurrency := FALSE;
// //                         GLSetup.GET;
// //                         CalcBestDirectUnitCost(TempPurchPrice);
// //                         SetCurrency("Currency Code", "Currency Factor", "Planning Date");

// //                         IF FoundPurchPrice OR
// //                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //                         THEN
// //                             "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

// //                     END;
// //                 Type::Resource:
// //                     BEGIN
// //                         ResCost.INIT;
// //                         ResCost.Code := "No.";
// //                         ResCost."Work Type Code" := "Work Type Code";
// //                         ResFindUnitCost.RUN(ResCost);

// //                         ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
// //                         "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
// //                         VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
// //                     END;
// //             END;
// //             VALIDATE("Direct Unit Cost (LCY)");
// //         END;
// //     end;

// //     procedure FindJobJnlLinePrice(var JobJnlLine: Record "Job Journal Line"; CalledByFieldNo: Integer);
// //     var
// //         JTHeader: Record Job;
// //     begin
// //         WITH JobJnlLine DO BEGIN
// //             SetCurrency("Currency Code", "Currency Factor", "Posting Date");
// //             SetVAT(FALSE, 0, '');
// //             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //             TESTFIELD("Qty. per Unit of Measure");

// //             CASE Type OF
// //                 Type::Item:
// //                     BEGIN
// //                         Item.GET("No.");
// //                         PriceInSKU := SKU.GET('', "No.", "Variant Code");
// //                         JTHeader.GET("Job No.");

// //                         FindPurchPrice(
// //                           TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", "Country/Region Code", "Posting Date", FALSE);
// //                         PricesInCurrency := FALSE;
// //                         GLSetup.GET;
// //                         CalcBestDirectUnitCost(TempPurchPrice);
// //                         SetCurrency("Currency Code", "Currency Factor", "Posting Date");

// //                         IF FoundPurchPrice OR
// //                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
// //                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
// //                         THEN
// //                             "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

// //                     END;
// //                 Type::Resource:
// //                     BEGIN
// //                         ResCost.INIT;
// //                         ResCost.Code := "No.";
// //                         ResCost."Work Type Code" := "Work Type Code";
// //                         ResFindUnitCost.RUN(ResCost);

// //                         ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
// //                         "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
// //                         VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
// //                     END;
// //             END;
// //             VALIDATE("Direct Unit Cost (LCY)");
// //         END;
// //     end;

// //     /// <summary>
// //     /// Description for NoOfPurchLinePrice.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure NoOfPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
// //     begin
// //         IF PurchLinePriceExists(PurchHeader, PurchLine, ShowAll) THEN
// //             EXIT(TempPurchPrice.COUNT);
// //     end;

// //     /// <summary>
// //     /// Description for NoOfPurchLineLineDisc.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     /// <param name="ShowAll">Parameter of type Boolean.</param>
// //     /// <returns>Return variable "Integer".</returns>
// //     procedure NoOfPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
// //     begin
// //         IF PurchLineLineDiscExists(PurchHeader, PurchLine, ShowAll) THEN
// //             EXIT(TempPurchLineDisc.COUNT);
// //     end;

// //     /// <summary>
// //     /// Description for GetPurchLinePrice.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     procedure GetPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
// //     begin
// //         PurchLinePriceExists(PurchHeader, PurchLine, TRUE);

// //         WITH PurchLine DO
// //             IF PAGE.RUNMODAL(PAGE::"Get Purchase Price", TempPurchPrice) = ACTION::LookupOK THEN BEGIN

// //                 SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
// //                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
// //                 SetCurrency(
// //                   PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));

// //                 IF NOT IsInMinQty(TempPurchPrice."Unit of Measure Code", TempPurchPrice."Minimum Quantity") THEN
// //                     ERROR(
// //                       Text020,
// //                       FIELDCAPTION(Quantity),
// //                       TempPurchPrice.FIELDCAPTION("Minimum Quantity"),
// //                       TempPurchPrice.TABLECAPTION);
// //                 IF NOT (TempPurchPrice."Currency Code" IN ["Currency Code", '']) THEN
// //                     ERROR(
// //                       Text040,
// //                       FIELDCAPTION("Currency Code"),
// //                       TABLECAPTION,
// //                       TempPurchPrice.TABLECAPTION);
// //                 IF NOT (TempPurchPrice."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
// //                     ERROR(
// //                       Text040,
// //                       FIELDCAPTION("Unit of Measure Code"),
// //                       TABLECAPTION,
// //                       TempPurchPrice.TABLECAPTION);
// //                 IF TempPurchPrice."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
// //                     ERROR(
// //                       Text020,
// //                       DateCaption,
// //                       TempPurchPrice.FIELDCAPTION("Starting Date"),
// //                       TempPurchPrice.TABLECAPTION);

// //                 ConvertPriceToVAT(
// //                   PurchHeader."Prices Including VAT", Item."VAT Prod. Posting Group",
// //                  "VAT Bus. Posting Group", TempPurchPrice."Direct Unit Cost");
// //                 ConvertPriceToUoM("Unit of Measure Code", TempPurchPrice."Direct Unit Cost");
// //                 ConvertPriceLCYToFCY(TempPurchPrice."Currency Code", TempPurchPrice."Direct Unit Cost");

// //                 VALIDATE("Direct Unit Cost", TempPurchPrice."Direct Unit Cost");
// //             END;
// //     end;

// //     /// <summary>
// //     /// Description for GetPurchLineLineDisc.
// //     /// </summary>
// //     /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
// //     /// <param name="PurchLine">Parameter of type Record "ADT Requisition Line".</param>
// //     procedure GetPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
// //     begin
// //         PurchLineLineDiscExists(PurchHeader, PurchLine, TRUE);

// //         WITH PurchLine DO
// //             IF PAGE.RUNMODAL(PAGE::"Get Purchase Line Disc.", TempPurchLineDisc) = ACTION::LookupOK THEN BEGIN
// //                 SetCurrency(PurchHeader."Currency Code", 0, 0D);
// //                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

// //                 IF NOT IsInMinQty(TempPurchLineDisc."Unit of Measure Code", TempPurchLineDisc."Minimum Quantity")
// //                 THEN
// //                     ERROR(
// //                       Text020, FIELDCAPTION(Quantity),
// //                       TempPurchLineDisc.FIELDCAPTION("Minimum Quantity"),
// //                       TempPurchLineDisc.TABLECAPTION);
// //                 IF NOT (TempPurchLineDisc."Currency Code" IN ["Currency Code", '']) THEN
// //                     ERROR(
// //                       Text040,
// //                       FIELDCAPTION("Currency Code"),
// //                       TABLECAPTION,
// //                       TempPurchLineDisc.TABLECAPTION);
// //                 IF NOT (TempPurchLineDisc."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
// //                     ERROR(
// //                       Text040,
// //                       FIELDCAPTION("Unit of Measure Code"),
// //                       TABLECAPTION,
// //                       TempPurchLineDisc.TABLECAPTION);
// //                 IF TempPurchLineDisc."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
// //                     ERROR(
// //                       Text020,
// //                       DateCaption,
// //                       TempPurchLineDisc.FIELDCAPTION("Starting Date"),
// //                       TempPurchLineDisc.TABLECAPTION);

// //                 VALIDATE("Line Discount %", TempPurchLineDisc."Line Discount %");
// //             END;
// //     end;

// //     //========Approval Workflow Management========

// //     // Page Management
// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
// //     local procedure OnAfterGetPageIDPRQ(RecordRef: RecordRef; var PageID: Integer)
// //     begin
// //         if PageID = 0 then
// //             PageID := GetConditionalCardPageIDPRQ(RecordRef);
// //     end;

// //     local procedure GetConditionalCardPageIDPRQ(RecordRef: RecordRef): Integer
// //     var
// //         RequisitionHeader: Record "ADT Requisition Header";
// //     begin
// //         RecordRef.SetTable(RequisitionHeader);
// //         case RequisitionHeader."Document Type" of
// //             RequisitionHeader."Document Type"::"Purchase Requisition":
// //                 if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
// //                     exit(PAGE::"Spare Part Requisition");
// //             RequisitionHeader."Document Type"::"Store Requisition":
// //                 if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
// //                     exit(PAGE::"Fuel Requisition");
// //         end;
// //     end;

// //     // End page management 

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
// //     local procedure OnOpenDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         Claim: Record "ADT Requisition Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     RecRef.SetTable(Claim);
// //                     Claim.Status := Claim.Status::Open;
// //                     Claim.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
// //     local procedure OnReleaseDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         Claim: Record "ADT Requisition Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     RecRef.SetTable(Claim);
// //                     Claim.Status := Claim.Status::Released;
// //                     Claim.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
// //     local procedure OnSetStatusToPendingApprovalPRQ(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
// //     var
// //         claim: Record "ADT Requisition Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     RecRef.SetTable(claim);
// //                     claim.Status := claim.Status::"Pending approval";
// //                     claim.Modify();
// //                     IsHandled := true;
// //                 end;
// //         end;
// //     end;

// //     /// <summary>
// //     /// CheckBudgetPurchase.
// //     /// </summary>
// //     /// <param name="RequisitionHeader">VAR Record "ADT Requisition Header".</param>
// //     procedure CheckBudgetPurchasePRQ(var RequisitionHeader: Record "ADT Requisition Header");
// //     var
// //         RequisitionLine: Record "ADT Requisition Line";
// //     begin
// //         // New vision requires that all requisition out of budget are escaladed to the CEO/CFO
// //         // for approval.
// //         if RequisitionHeader."Document Type" = RequisitionHeader."Document Type"::"Purchase Requisition" then begin
// //             //RequisitionHeader.TESTFIELD("Budget Code");
// //             RequisitionHeader.TESTFIELD("Shortcut Dimension 1 Code");
// //             RequisitionLine.RESET;
// //             IF RequisitionHeader.Status = RequisitionHeader.Status::"Pending Approval" THEN BEGIN
// //                 // Budget holder should enter the codes before approving the document.
// //                 RequisitionLine.SETRANGE("Document Type", RequisitionHeader."Document Type");
// //                 RequisitionLine.SETRANGE("Document No.", RequisitionHeader."No.");
// //                 IF RequisitionLine.FIND('-') THEN
// //                     REPEAT
// //                         IF RequisitionLine.Type = RequisitionLine.Type::"G/L Account" THEN BEGIN
// //                             if RequisitionLine."G/L Account Type" = RequisitionLine."G/L Account Type"::"Income Statement" then begin
// //                                 IF RequisitionLine."Budget Comment" = 'Out of Budget' THEN BEGIN
// //                                     ERROR('Purchase Requisition Line %1 is Out of Budget and must be escalated to CFO/CEO!', RequisitionLine."Line No.");
// //                                 END;
// //                             end;
// //                         END;
// //                     UNTIL RequisitionLine.NEXT = 0;
// //             END;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
// //     local procedure OnAddWorkflowResponsePredecessorsToLibraryPRQ(ResponseFunctionName: Code[128])
// //     var
// //         WorkflowResponseHandling: Codeunit 1521;
// //         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
// //     begin
// //         case ResponseFunctionName of
// //             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
// //             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
// //             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
// //             WorkflowResponseHandling.OpenDocumentCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
// //         end;
// //     end;

// //     // Approval Management
// //     // ====================================//////////////////////////////////
// //     /// <summary>
// //     /// CheckClaimApprovalsWorkflowEnable.
// //     /// </summary>
// //     /// <param name="Claim">VAR Record "ADT Requisition Header".</param>
// //     /// <returns>Return value of type Boolean.</returns>
// //     procedure CheckClaimApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
// //     begin
// //         if not IsClaimDocApprovalsWorkflowEnablePRQ(Claim) then
// //             Error(NoWorkflowEnabledErrPRQ);
// //         exit(true);
// //     end;

// //     /// <summary>
// //     /// IsClaimDocApprovalsWorkflowEnable.
// //     /// </summary>
// //     /// <param name="Claim">VAR Record "ADT Requisition Header".</param>
// //     /// <returns>Return value of type Boolean.</returns>
// //     procedure IsClaimDocApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
// //     begin
// //         if Claim.Status <> Claim.Status::Open then
// //             exit(false);
// //         exit(WorkflowManagementPRQ.CanExecuteWorkflow(Claim, WorkflowEventHandlingCustPRQ.RunWorkflowOnSendClaimForApprovalCodePRQ));
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
// //     local procedure OnPopulateApprovalEntryArgumentPRQ(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
// //     var
// //         Claim: Record "ADT Requisition Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     RecRef.SetTable(Claim);
// //                     ApprovalEntryArgument."Document No." := Claim."No.";
// //                     ApprovalEntryArgument."Requisition Type" := Claim."Document Type"::"Store Requisition";
// //                 end;
// //         end;
// //     end;

// //     /// <summary>
// //     /// OnSendClaimForApproval.
// //     /// </summary>
// //     /// <param name="Claim">VAR Record "ADT Requisition Header".</param>
// //     [IntegrationEvent(false, false)]
// //     procedure OnSendClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
// //     begin

// //     end;

// //     /// <summary>
// //     /// OnCancelClaimForApproval.
// //     /// </summary>
// //     /// <param name="Claim">VAR Record "ADT Requisition Header".</param>
// //     [IntegrationEvent(false, false)]
// //     procedure OnCancelClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
// //     begin

// //     end;

// //     /// <summary>
// //     /// ReOpenLoanAdvance.
// //     /// </summary>
// //     /// <param name="Variant">VAR Variant.</param>
// //     procedure ReOpenLoanAdvancePRQ(var Variant: Variant)
// //     var
// //         RecRef: RecordRef;
// //         TargetRecRef: RecordRef;
// //         ApprovalEntry: Record "Approval Entry";
// //         LoanAdvance: Record "ADT Requisition Header";
// //     begin
// //         RecRef.GetTable(Variant);
// //         case RecRef.Number() of
// //             DATABASE::"Approval Entry":
// //                 begin
// //                     ApprovalEntry := Variant;
// //                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
// //                     Variant := TargetRecRef;
// //                     ReOpenLoanAdvancePRQ(Variant);
// //                 end;
// //             DATABASE::Job:
// //                 begin
// //                     RecRef.SetTable(LoanAdvance);
// //                     LoanAdvance.Validate(Status, LoanAdvance.Status::Open);
// //                     LoanAdvance.Modify();
// //                     Variant := LoanAdvance;
// //                 end;
// //         end;
// //     end;

// //     /// <summary>
// //     /// modifyApprovalEntry.
// //     /// </summary>
// //     /// <param name="PurchaseReqHeader">Record "ADT Requisition Header".</param>
// //     procedure modifyApprovalEntryPRQ(PurchaseReqHeader: Record "ADT Requisition Header")
// //     var
// //         NflRequisitionLine: Record "ADT Requisition Line";
// //         AmountLcy: Decimal;
// //         ApprovalEntry: Record "Approval Entry";
// //     begin
// //         AmountLcy := 0;
// //         PurchaseReqHeader.CalcFields("Total Cost");
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseReqHeader."No.");
// //         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //         if ApprovalEntry.FindFirst() then
// //             repeat
// //                 if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Purchase Requisition" then begin
// //                     ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
// //                     ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
// //                     ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
// //                     ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
// //                     ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
// //                     ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
// //                     ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
// //                     ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
// //                     ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
// //                 end else
// //                     if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Store Requisition" then begin
// //                         ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
// //                         ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
// //                         ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
// //                         ApprovalEntry.Amount := PurchaseReqHeader."Total Cost";
// //                         ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
// //                         ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
// //                         ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
// //                         ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
// //                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
// //                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
// //                     end;
// //                 ApprovalEntry.Modify();
// //             until ApprovalEntry.Next() = 0;
// //     end;

// //     /// <summary>
// //     /// UpdateApprovalEntryInfo.
// //     /// </summary>
// //     procedure UpdateApprovalEntryInfoPRQ()
// //     var
// //         PurchReq: Record "ADT Requisition Header";
// //         ApprovalEntry: Record "Approval Entry";
// //     begin

// //         PurchReq.Reset();
// //         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Purchase Requisition");
// //         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
// //         if PurchReq.FindFirst() then
// //             repeat
// //                 PurchReq.CalcFields("Total Cost");
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := PurchReq."Document Type";
// //                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
// //                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
// //                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
// //                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
// //                         ApprovalEntry.Description := PurchReq."Posting Description";
// //                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
// //                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
// //                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until PurchReq.Next() = 0;


// //         PurchReq.Reset();
// //         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
// //         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
// //         if PurchReq.FindFirst() then
// //             repeat
// //                 PurchReq.CalcFields("Total Cost");
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := PurchReq."Document Type";
// //                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
// //                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
// //                         ApprovalEntry.Amount := PurchReq."Total Cost";
// //                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
// //                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
// //                         ApprovalEntry.Description := PurchReq."Posting Description";
// //                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
// //                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
// //                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until PurchReq.Next() = 0;
// //         Message('Done Now');
// //     end;

// //     procedure UpdateApprovalEntryInfoSTRQ()
// //     var
// //         PurchReq: Record "ADT Requisition Header";
// //         ApprovalEntry: Record "Approval Entry";
// //     begin

// //         PurchReq.Reset();
// //         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
// //         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
// //         if PurchReq.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := PurchReq."Document Type";
// //                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
// //                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
// //                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
// //                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
// //                         ApprovalEntry.Description := PurchReq."Posting Description";
// //                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
// //                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
// //                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until PurchReq.Next() = 0;
// //         Message('Done Now');
// //     end;


// //     //Approval managed
// //     /// <summary>
// //     /// OpenApprovalEntries.
// //     /// </summary>
// //     /// <param name="Rec">Record "ADT Requisition Header".</param>
// //     procedure OpenApprovalEntriesPRQ(Rec: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         SequenceNo: Integer;
// //     // NFLApprovalMgt: Codeunit "NFL Approvals Mgt Notification";
// //     begin
// //         SequenceNo := 0;
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
// //         if ApprovalEntries.FindFirst() then begin
// //             SequenceNo := ApprovalEntries."Sequence No." + 1;
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
// //             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
// //                 ApprovalEntries1.Modify();
// //                 // NFLApprovalMgt.SendNFLRequisitionApprovalMail(Rec, ApprovalEntries1);
// //             end;
// //         end;
// //     end;

// //     // Reject The approval request.
// //     /// <summary>
// //     /// RejectApprovalRequest.
// //     /// </summary>
// //     /// <param name="Rec">Record "ADT Requisition Header".</param>
// //     procedure RejectApprovalRequestPRQ(Rec: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         // NFLApprovalMgt: Codeunit "NFL Approvals Mgt Notification";
// //         NvText: Label 'The approval Request has been rejected';
// //     begin
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
// //         if ApprovalEntries.FindFirst() then begin
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
// //                     ApprovalEntries1.Modify();
// //                 until ApprovalEntries1.Next() = 0;
// //             end;
// //             OpenDocumentPRQ(Rec);
// //             Message(NvText);
// //         end;
// //     end;

// //     // open the rejected Document
// //     /// <summary>
// //     /// OpenDocument.
// //     /// </summary>
// //     /// <param name="Rec">Record "ADT Requisition Header".</param>
// //     procedure OpenDocumentPRQ(Rec: Record "ADT Requisition Header")
// //     var
// //         NFLRequisitionHeader: Record "ADT Requisition Header";
// //     begin
// //         NFLRequisitionHeader.Reset();
// //         NFLRequisitionHeader.SetRange(NFLRequisitionHeader."No.", Rec."No.");
// //         NFLRequisitionHeader.SetRange(NFLRequisitionHeader.Status, NFLRequisitionHeader.Status::"Pending Approval");
// //         if NFLRequisitionHeader.FindFirst() then begin
// //             NFLRequisitionHeader.Status := NFLRequisitionHeader.Status::Open;
// //             NFLRequisitionHeader.Modify();
// //         end;
// //     end;

// //     /// <summary>
// //     /// DelegatePurchaseApprovalRequest.
// //     /// </summary>
// //     /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
// //     procedure DelegatePurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         UserSetup: Record "User Setup";
// //         Txt00003: Label 'Are you sure you want to delegate to:';
// //         MessageToSend: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             UserSetup.Reset();
// //             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
// //             if UserSetup.FindFirst() then begin
// //                 if UserSetup.Substitute <> '' then begin
// //                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
// //                     if Confirm(MessageToSend, true) then begin
// //                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
// //                         ApprovalEntry."Last Modified By User ID" := UserId;
// //                         ApprovalEntry.Modify();
// //                         Message('Requisition has been Delegated to %1 Successfully', UserSetup.Substitute);
// //                     end;
// //                 end else begin
// //                     Error('Substitute can not be empty. Contact your Systems Administrator');
// //                 end;
// //             end else begin
// //                 Error('You are not setup please consult your System Administrator');
// //             end;
// //         end else begin
// //             Error('You are not allowed to Delegate please contact your system Administrator');
// //         end;
// //     end;

// //     /// <summary>
// //     /// escalateDoc.
// //     /// </summary>
// //     /// <param name="ApproveCode">VAR Code[50].</param>
// //     /// <param name="DocNo">Code[50].</param>
// //     /// <param name="userIDEsc">Code[50].</param>
// //     /// <param name="EscalateTo">Code[50].</param>
// //     /// <param name="NFLRequisitionHeader">Record "ADT Requisition Header".</param>
// //     procedure escalateDocPRQ(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; NFLRequisitionHeader: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         Txt0010: Label 'Are you sure you want to escalate to';
// //         SendMessage: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             SendMessage := Txt0010 + ' ' + EscalateTo;
// //             if Confirm(SendMessage, true) then begin
// //                 ApprovalEntry."Approver ID" := EscalateTo;
// //                 ApprovalEntry."Escalated By" := userIDEsc;
// //                 ApprovalEntry."Escalated On" := Today();
// //                 ApprovalEntry.Modify();
// //                 Message('Document has been Escalated to: %1', EscalateTo);
// //             end else
// //                 Message('The Document has not been escalate');
// //         end;
// //     end;

// //     /// <summary>
// //     /// CancelPurchaseApprovalRequest.
// //     /// </summary>
// //     /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
// //     procedure CancelPurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         PurchRequisitionHeader: Record "ADT Requisition Header";
// //     begin
// //         PurchRequisitionHeader.Reset();
// //         PurchRequisitionHeader.SetRange(PurchRequisitionHeader."No.", RequisitionHeader."No.");
// //         PurchRequisitionHeader.SetRange(PurchRequisitionHeader.Status, PurchRequisitionHeader.Status::"Pending Approval");
// //         if PurchRequisitionHeader.FindFirst() then begin
// //             ApprovalEntry.Reset();
// //             ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
// //             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
// //             if ApprovalEntry.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                     ApprovalEntry."Last Modified By User ID" := UserId;
// //                     ApprovalEntry.Modify();
// //                 until ApprovalEntry.Next() = 0;
// //             end;
// //             PurchRequisitionHeader.Status := PurchRequisitionHeader.Status::Open;
// //             PurchRequisitionHeader.Modify();
// //         end;
// //         Message('The Request has been Cancelled');
// //     end;


// //     /// <summary>
// //     /// ReopenApprovalEntries.
// //     /// </summary>
// //     /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>

// //     procedure ReopenApprovalEntriesPRQ(RequisitionHeader: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         // NFLApprovalMgt: Codeunit "NFL Approvals Mgt Notification";
// //         UserSetUp: Record "User Setup";
// //         VoucherAdmin: Boolean;
// //     begin
// //         if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
// //             exit;

// //         VoucherAdmin := false;
// //         UserSetUp.Reset();
// //         UserSetUp.SetRange(UserSetUp."User ID", UserId);
// //         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
// //         if UserSetUp.FindFirst() then begin
// //             VoucherAdmin := true;
// //         end;
// //         if (VoucherAdmin = true) then begin
// //             if (RequisitionHeader.Status = RequisitionHeader.Status::Open) then begin
// //                 ApprovalEntry.Reset();
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
// //                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             end;
// //         end;

// //     end;

// //     procedure EscalateGeneralRequisition(var Requisition: Record "ADT Requisition Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         UserSetup: Record "User Setup";
// //         Text001: Text;
// //     begin
// //         Requisition.CalcFields("Current Approver");
// //         //get the escalate ID
// //         UserSetup.Reset();
// //         UserSetup.SetRange("User ID", Requisition."Current Approver");
// //         UserSetup.SetRange("SBU Head", true);
// //         if UserSetup.FindFirst() then begin
// //             UserSetup.TestField("Escalate to");
// //             Text001 := 'The Requisition will be escalated to ' + UserSetup."Escalate to" + ' do you want to continue?';
// //             if Confirm(Text001, true) then begin
// //                 ApprovalEntries.Reset();
// //                 ApprovalEntries.SetRange("Approver ID", Requisition."Current Approver");
// //                 ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);
// //                 ApprovalEntries.SetRange("Document No.", Requisition."No.");
// //                 if ApprovalEntries.FindFirst() then begin
// //                     ApprovalEntries.Validate("Approver ID", UserSetup."Escalate to");
// //                     ApprovalEntries.Validate("Escalated By", UserId);
// //                     ApprovalEntries.Validate("Escalated On", Today());
// //                     ApprovalEntries.Modify();
// //                     Message('The Requisition has been escalated to %1', UserSetup."Escalate to");
// //                 end;
// //             end;
// //         end else begin
// //             Error('No User Setup record found for user: %1', Requisition."Current Approver");
// //         end;
// //     end;

// //     //========End Approval Workflow Management========

// //     //===============Approval workflow mgt for Maintenance Request================
// //     // Page Management
// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
// //     local procedure OnAfterGetPageIDMR(RecordRef: RecordRef; var PageID: Integer)
// //     begin
// //         if PageID = 0 then
// //             PageID := GetConditionalCardPageIDMR(RecordRef);
// //     end;

// //     local procedure GetConditionalCardPageIDMR(RecordRef: RecordRef): Integer
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         RecordRef.SetTable(MaintenanceHeader);
// //         case MaintenanceHeader."Document Type" of
// //             MaintenanceHeader."Document Type"::"Maintenance Request":
// //                 exit(PAGE::"Maintenance Request");
// //             MaintenanceHeader."Document Type"::"Job Card":
// //                 exit(PAGE::"Maintenance Job Card");
// //         end;
// //     end;

// //     // End page management 

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
// //     local procedure OnOpenDocumentMR(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Maintenance Header":
// //                 begin
// //                     RecRef.SetTable(MaintenanceHeader);
// //                     MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
// //                     MaintenanceHeader.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
// //     local procedure OnReleaseDocumentMR(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Maintenance Header":
// //                 begin
// //                     RecRef.SetTable(MaintenanceHeader);
// //                     MaintenanceHeader.Status := MaintenanceHeader.Status::Released;
// //                     MaintenanceHeader.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
// //     local procedure OnSetStatusToPendingApprovalMR(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Maintenance Header":
// //                 begin
// //                     RecRef.SetTable(MaintenanceHeader);
// //                     MaintenanceHeader.Status := MaintenanceHeader.Status::"Pending approval";
// //                     MaintenanceHeader.Modify();
// //                     IsHandled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
// //     local procedure OnAddWorkflowResponsePredecessorsToLibraryMR(ResponseFunctionName: Code[128])
// //     var
// //         WorkflowResponseHandling: Codeunit 1521;
// //         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
// //     begin
// //         case ResponseFunctionName of
// //             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
// //             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
// //             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
// //             WorkflowResponseHandling.OpenDocumentCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
// //         end;
// //     end;


// //     procedure CheckClaimApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
// //     begin
// //         if not IsClaimDocApprovalsWorkflowEnableMR(MaintenanceHeader) then
// //             Error(NoWorkflowEnabledErrMR);
// //         exit(true);
// //     end;

// //     procedure IsClaimDocApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
// //     begin
// //         if MaintenanceHeader.Status <> MaintenanceHeader.Status::Open then
// //             exit(false);
// //         exit(WorkflowManagementMR.CanExecuteWorkflow(MaintenanceHeader, WorkflowEventHandlingCustMR.RunWorkflowOnSendClaimForApprovalCodeMR));
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
// //     local procedure OnPopulateApprovalEntryArgumentMR(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Maintenance Header":
// //                 begin
// //                     RecRef.SetTable(MaintenanceHeader);
// //                     ApprovalEntryArgument."Document No." := MaintenanceHeader."No.";
// //                 end;
// //         end;
// //     end;

// //     [IntegrationEvent(false, false)]
// //     procedure OnSendClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
// //     begin

// //     end;

// //     [IntegrationEvent(false, false)]
// //     procedure OnCancelClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
// //     begin

// //     end;

// //     procedure ReOpenLoanAdvanceMR(var Variant: Variant)
// //     var
// //         RecRef: RecordRef;
// //         TargetRecRef: RecordRef;
// //         ApprovalEntry: Record "Approval Entry";
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         RecRef.GetTable(Variant);
// //         case RecRef.Number() of
// //             DATABASE::"Approval Entry":
// //                 begin
// //                     ApprovalEntry := Variant;
// //                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
// //                     Variant := TargetRecRef;
// //                     ReOpenLoanAdvanceMR(Variant);
// //                 end;
// //             DATABASE::"Maintenance Header":
// //                 begin
// //                     RecRef.SetTable(MaintenanceHeader);
// //                     MaintenanceHeader.Validate(Status, MaintenanceHeader.Status::Open);
// //                     MaintenanceHeader.Modify();
// //                     Variant := MaintenanceHeader;
// //                 end;
// //         end;
// //     end;

// //     procedure modifyApprovalEntryMR(MaintenanceHeader: Record "Maintenance Header")
// //     var
// //         AmountLcy: Decimal;
// //         ApprovalEntry: Record "Approval Entry";
// //     begin
// //         AmountLcy := 0;
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
// //         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //         if ApprovalEntry.FindFirst() then
// //             repeat
// //                 if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Maintenance Request" then begin
// //                     ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
// //                     ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
// //                     ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
// //                     ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
// //                 end else if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Job Card" then begin
// //                     ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
// //                     ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
// //                     ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
// //                     ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
// //                 end;
// //                 ApprovalEntry.Modify();
// //             until ApprovalEntry.Next() = 0;
// //     end;

// //     procedure UpdateApprovalEntryInfoMR()
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //         ApprovalEntry: Record "Approval Entry";
// //     begin

// //         MaintenanceHeader.Reset();
// //         MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Maintenance Request");
// //         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
// //         if MaintenanceHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
// //                         ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
// //                         ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
// //                         ApprovalEntry.Amount := 0; // Assuming Amount is not applicable for Maintenance Requests
// //                         ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);

// //                         ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until MaintenanceHeader.Next() = 0;

// //         MaintenanceHeader.Reset();
// //         MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Job Card");
// //         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
// //         if MaintenanceHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
// //                         ApprovalEntry.Amount := 0; // Assuming Amount is not applicable for Job Cards
// //                         ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
// //                         ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
// //                         ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
// //                         ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until MaintenanceHeader.Next() = 0;
// //     end;

// //     procedure OpenApprovalEntriesMR(Rec: Record "Maintenance Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         SequenceNo: Integer;
// //     begin
// //         SequenceNo := 0;
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
// //         if ApprovalEntries.FindFirst() then begin
// //             SequenceNo := ApprovalEntries."Sequence No." + 1;
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
// //             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
// //                 ApprovalEntries1.Modify();
// //             end;
// //         end;
// //     end;

// //     procedure RejectApprovalRequestMR(Rec: Record "Maintenance Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         NvText: Label 'The approval Request has been rejected';
// //     begin
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
// //         if ApprovalEntries.FindFirst() then begin
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
// //                     ApprovalEntries1.Modify();
// //                 until ApprovalEntries1.Next() = 0;
// //             end;
// //             OpenDocumentMR(Rec);
// //             Message(NvText);
// //         end;
// //     end;

// //     procedure OpenDocumentMR(Rec: Record "Maintenance Header")
// //     var
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         MaintenanceHeader.Reset();
// //         MaintenanceHeader.SetRange(MaintenanceHeader."No.", Rec."No.");
// //         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
// //         if MaintenanceHeader.FindFirst() then begin
// //             MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
// //             MaintenanceHeader.Modify();
// //         end;
// //     end;

// //     procedure DelegatePurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         UserSetup: Record "User Setup";
// //         Txt00003: Label 'Are you sure you want to delegate to:';
// //         MessageToSend: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             UserSetup.Reset();
// //             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
// //             if UserSetup.FindFirst() then begin
// //                 if UserSetup.Substitute <> '' then begin
// //                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
// //                     if Confirm(MessageToSend, true) then begin
// //                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
// //                         ApprovalEntry."Last Modified By User ID" := UserId;
// //                         ApprovalEntry.Modify();
// //                         Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
// //                     end;
// //                 end else begin
// //                     Error('Substitute can not be empty. Contact your Systems Administrator');
// //                 end;
// //             end else begin
// //                 Error('You are not setup please consult your System Administrator');
// //             end;
// //         end else begin
// //             Error('You are not allowed to Delegate please contact your system Administrator');
// //         end;
// //     end;

// //     procedure escalateDocMR(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; MaintenanceHeader: Record "Maintenance Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         Txt0010: Label 'Are you sure you want to escalate to';
// //         SendMessage: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             SendMessage := Txt0010 + ' ' + EscalateTo;
// //             if Confirm(SendMessage, true) then begin
// //                 ApprovalEntry."Approver ID" := EscalateTo;
// //                 ApprovalEntry."Escalated By" := userIDEsc;
// //                 ApprovalEntry."Escalated On" := Today();
// //                 ApprovalEntry.Modify();
// //                 Message('Document has been Escalated to: %1', EscalateTo);
// //             end else
// //                 Message('The Document has not been escalate');
// //         end;
// //     end;

// //     procedure CancelPurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         RequisitionHeader: Record "Maintenance Header";
// //     begin
// //         RequisitionHeader.Reset();
// //         RequisitionHeader.SetRange(RequisitionHeader."No.", MaintenanceHeader."No.");
// //         RequisitionHeader.SetRange(RequisitionHeader.Status, RequisitionHeader.Status::"Pending Approval");
// //         if RequisitionHeader.FindFirst() then begin
// //             ApprovalEntry.Reset();
// //             ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
// //             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
// //             if ApprovalEntry.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                     ApprovalEntry."Last Modified By User ID" := UserId;
// //                     ApprovalEntry.Modify();
// //                 until ApprovalEntry.Next() = 0;
// //             end;
// //             RequisitionHeader.Status := RequisitionHeader.Status::Open;
// //             RequisitionHeader.Modify();
// //         end;
// //         Message('The Request has been Cancelled');
// //     end;

// //     procedure ReopenApprovalEntriesMR(RequisitionHeader: Record "Maintenance Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         UserSetUp: Record "User Setup";
// //         VoucherAdmin: Boolean;
// //     begin
// //         if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
// //             exit;

// //         VoucherAdmin := false;
// //         UserSetUp.Reset();
// //         UserSetUp.SetRange(UserSetUp."User ID", UserId);
// //         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
// //         if UserSetUp.FindFirst() then begin
// //             VoucherAdmin := true;
// //         end;
// //         if (VoucherAdmin = true) then begin
// //             if (RequisitionHeader.Status = RequisitionHeader.Status::Open) then begin
// //                 ApprovalEntry.Reset();
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
// //                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             end;
// //         end;
// //     end;
// //     //===============End Approval workflow mgt for Maintenance Request================

// //     //===================================////////////////////////////////////////=======================================

// //     //===============Approval workflow mgt for form Request================
// //     // Page Management
// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
// //     local procedure OnAfterGetPageIDFM(RecordRef: RecordRef; var PageID: Integer)
// //     begin
// //         if PageID = 0 then
// //             PageID := GetConditionalCardPageIDFM(RecordRef);
// //     end;

// //     local procedure GetConditionalCardPageIDFM(RecordRef: RecordRef): Integer
// //     var
// //         FormHeader: Record "Form Header";
// //         RequisitionHeader: Record "ADT Requisition Header";
// //         MaintenanceHeader: Record "Maintenance Header";
// //     begin
// //         if RecordRef.Number = Database::"Form Header" then begin
// //             RecordRef.SetTable(FormHeader);
// //             case FormHeader."Document Type" of
// //                 FormHeader."Document Type"::"Equipment Hand Over":
// //                     exit(PAGE::"Equipment HandOver Form");
// //                 FormHeader."Document Type"::"External Hire":
// //                     exit(Page::"External Hire Request");
// //                 FormHeader."Document Type"::"Journey Management Plan":
// //                     exit(Page::"Journey Management Plan");
// //             end;
// //         end;
// //         if RecordRef.Number = Database::"ADT Requisition Header" then begin
// //             RecordRef.SetTable(RequisitionHeader);
// //             case RequisitionHeader."Document Type" of
// //                 RequisitionHeader."Document Type"::"Purchase Requisition":
// //                     if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
// //                         exit(PAGE::"Spare Part Requisition");
// //                 RequisitionHeader."Document Type"::"Store Requisition":
// //                     if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
// //                         exit(PAGE::"Fuel Requisition");
// //             end;
// //         end;
// //         if RecordRef.Number = Database::"Maintenance Header" then begin
// //             RecordRef.SetTable(MaintenanceHeader);
// //             case MaintenanceHeader."Document Type" of
// //                 MaintenanceHeader."Document Type"::"Maintenance Request":
// //                     exit(PAGE::"Maintenance Request");
// //                 MaintenanceHeader."Document Type"::"Job Card":
// //                     exit(PAGE::"Maintenance Job Card");
// //             end;
// //         end
// //     end;

// //     // End page management 

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
// //     local procedure OnOpenDocumentFM(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         FormHeader: Record "Form Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Form Header":
// //                 begin
// //                     RecRef.SetTable(FormHeader);
// //                     FormHeader.Status := FormHeader.Status::Open;
// //                     FormHeader.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
// //     local procedure OnReleaseDocumentFM(RecRef: RecordRef; var Handled: Boolean)
// //     var
// //         FormHeader: Record "Form Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Form Header":
// //                 begin
// //                     RecRef.SetTable(FormHeader);
// //                     FormHeader.Status := FormHeader.Status::Released;
// //                     FormHeader.Modify();
// //                     Handled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
// //     local procedure OnSetStatusToPendingApprovalFM(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
// //     var
// //         FormHeader: Record "Form Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Form Header":
// //                 begin
// //                     RecRef.SetTable(FormHeader);
// //                     FormHeader.Status := FormHeader.Status::"Pending approval";
// //                     FormHeader.Modify();
// //                     IsHandled := true;
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
// //     local procedure OnAddWorkflowResponsePredecessorsToLibraryFM(ResponseFunctionName: Code[128])
// //     var
// //         WorkflowResponseHandling: Codeunit 1521;
// //         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
// //     begin
// //         case ResponseFunctionName of
// //             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
// //             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
// //             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
// //             WorkflowResponseHandling.OpenDocumentCode:
// //                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
// //                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
// //         end;
// //     end;


// //     procedure CheckClaimApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
// //     begin
// //         if not IsClaimDocApprovalsWorkflowEnableFM(FormHeader) then
// //             Error(NoWorkflowEnabledErrFM);
// //         exit(true);
// //     end;

// //     procedure IsClaimDocApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
// //     begin
// //         if FormHeader.Status <> FormHeader.Status::Open then
// //             exit(false);
// //         exit(WorkflowManagementFM.CanExecuteWorkflow(FormHeader, WorkflowEventHandlingCustFM.RunWorkflowOnSendClaimForApprovalCodeFM));
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
// //     local procedure OnPopulateApprovalEntryArgumentFM(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
// //     var
// //         FormHeader: Record "Form Header";
// //     begin
// //         case RecRef.Number of
// //             Database::"Form Header":
// //                 begin
// //                     RecRef.SetTable(FormHeader);
// //                     ApprovalEntryArgument."Document No." := FormHeader."No.";
// //                 end;
// //         end;
// //     end;

// //     [IntegrationEvent(false, false)]
// //     procedure OnSendClaimForApprovalFM(var FormHeader: Record "Form Header")
// //     begin

// //     end;

// //     [IntegrationEvent(false, false)]
// //     procedure OnCancelClaimForApprovalFM(var FormHeader: Record "Form Header")
// //     begin

// //     end;

// //     procedure ReOpenLoanAdvanceFM(var Variant: Variant)
// //     var
// //         RecRef: RecordRef;
// //         TargetRecRef: RecordRef;
// //         ApprovalEntry: Record "Approval Entry";
// //         FormHeader: Record "Form Header";
// //     begin
// //         RecRef.GetTable(Variant);
// //         case RecRef.Number() of
// //             DATABASE::"Approval Entry":
// //                 begin
// //                     ApprovalEntry := Variant;
// //                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
// //                     Variant := TargetRecRef;
// //                     ReOpenLoanAdvanceFM(Variant);
// //                 end;
// //             DATABASE::"Form Header":
// //                 begin
// //                     RecRef.SetTable(FormHeader);
// //                     FormHeader.Validate(Status, FormHeader.Status::Open);
// //                     FormHeader.Modify();
// //                     Variant := FormHeader;
// //                 end;
// //         end;
// //     end;

// //     procedure modifyApprovalEntryFM(FormHeader: Record "Form Header")
// //     var
// //         AmountLcy: Decimal;
// //         ApprovalEntry: Record "Approval Entry";
// //     begin
// //         AmountLcy := 0;
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //         if ApprovalEntry.FindFirst() then
// //             repeat
// //                 if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Hand Over" then begin
// //                     ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Posting Date" := FormHeader.Date;
// //                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Inspection" then begin
// //                     ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Posting Date" := FormHeader.Date;
// //                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"External Hire" then begin
// //                     ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Posting Date" := FormHeader.Date;
// //                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"Journey Management Plan" then begin
// //                     ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                     ApprovalEntry.Amount := 0;
// //                     ApprovalEntry."Posting Date" := FormHeader.Date;
// //                 end;
// //                 ApprovalEntry.Modify();
// //             until ApprovalEntry.Next() = 0;
// //     end;

// //     procedure UpdateApprovalEntryInfoFM()
// //     var
// //         FormHeader: Record "Form Header";
// //         ApprovalEntry: Record "Approval Entry";
// //     begin

// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Hand Over");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";

// //                         ApprovalEntry."Posting Date" := FormHeader.Date;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until FormHeader.Next() = 0;

// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Inspection");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                         ApprovalEntry.Amount := 0; // Assuming Amount is not applicable for Job Cards
// //                         ApprovalEntry."Posting Date" := FormHeader.Date;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until FormHeader.Next() = 0;

// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"External Hire");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                         ApprovalEntry.Amount := 0; // Assuming Amount is not applicable for Job Cards
// //                         ApprovalEntry."Posting Date" := FormHeader.Date;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until FormHeader.Next() = 0;

// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Journey Management Plan");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then
// //             repeat
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry."Document Type" := FormHeader."Document Type";
// //                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
// //                         ApprovalEntry.Amount := 0; // Assuming Amount is not applicable for Job Cards
// //                         ApprovalEntry."Posting Date" := FormHeader.Date;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             until FormHeader.Next() = 0;
// //     end;

// //     procedure OpenApprovalEntriesFM(Rec: Record "Form Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         SequenceNo: Integer;
// //     begin
// //         SequenceNo := 0;
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
// //         if ApprovalEntries.FindFirst() then begin
// //             SequenceNo := ApprovalEntries."Sequence No." + 1;
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
// //             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
// //                 ApprovalEntries1.Modify();
// //             end;
// //         end;
// //     end;

// //     procedure RejectApprovalRequestFM(Rec: Record "Form Header")
// //     var
// //         ApprovalEntries: Record "Approval Entry";
// //         ApprovalEntries1: Record "Approval Entry";
// //         NvText: Label 'The approval Request has been rejected';
// //     begin
// //         ApprovalEntries.Reset();
// //         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
// //         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
// //         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
// //         if ApprovalEntries.FindFirst() then begin
// //             ApprovalEntries1.Reset();
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
// //             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
// //             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
// //             if ApprovalEntries1.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
// //                     ApprovalEntries1.Modify();
// //                 until ApprovalEntries1.Next() = 0;
// //             end;
// //             OpenDocumentFM(Rec);
// //             Message(NvText);
// //         end;
// //     end;

// //     procedure OpenDocumentFM(Rec: Record "Form Header")
// //     var
// //         FormHeader: Record "Form Header";
// //     begin
// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."No.", Rec."No.");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then begin
// //             FormHeader.Status := FormHeader.Status::Open;
// //             FormHeader.Modify();
// //         end;
// //     end;

// //     procedure DelegatePurchaseApprovalRequestFM(FormHeader: Record "Form Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         UserSetup: Record "User Setup";
// //         Txt00003: Label 'Are you sure you want to delegate to:';
// //         MessageToSend: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             UserSetup.Reset();
// //             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
// //             if UserSetup.FindFirst() then begin
// //                 if UserSetup.Substitute <> '' then begin
// //                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
// //                     if Confirm(MessageToSend, true) then begin
// //                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
// //                         ApprovalEntry."Last Modified By User ID" := UserId;
// //                         ApprovalEntry.Modify();
// //                         Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
// //                     end;
// //                 end else begin
// //                     Error('Substitute can not be empty. Contact your Systems Administrator');
// //                 end;
// //             end else begin
// //                 Error('You are not setup please consult your System Administrator');
// //             end;
// //         end else begin
// //             Error('You are not allowed to Delegate please contact your system Administrator');
// //         end;
// //     end;

// //     procedure escalateDocFM(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; FormHeader: Record "Form Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         Txt0010: Label 'Are you sure you want to escalate to';
// //         SendMessage: Text[100];
// //     begin
// //         ApprovalEntry.Reset();
// //         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
// //         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
// //         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
// //         if ApprovalEntry.FindFirst() then begin
// //             SendMessage := Txt0010 + ' ' + EscalateTo;
// //             if Confirm(SendMessage, true) then begin
// //                 ApprovalEntry."Approver ID" := EscalateTo;
// //                 ApprovalEntry."Escalated By" := userIDEsc;
// //                 ApprovalEntry."Escalated On" := Today();
// //                 ApprovalEntry.Modify();
// //                 Message('Document has been Escalated to: %1', EscalateTo);
// //             end else
// //                 Message('The Document has not been escalate');
// //         end;
// //     end;

// //     procedure CancelPurchaseApprovalRequestFM(FormHeader1: Record "Form Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         FormHeader: Record "Form Header";
// //     begin
// //         FormHeader.Reset();
// //         FormHeader.SetRange(FormHeader."No.", FormHeader1."No.");
// //         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
// //         if FormHeader.FindFirst() then begin
// //             ApprovalEntry.Reset();
// //             ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader1."No.");
// //             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
// //             if ApprovalEntry.FindFirst() then begin
// //                 repeat
// //                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                     ApprovalEntry."Last Modified By User ID" := UserId;
// //                     ApprovalEntry.Modify();
// //                 until ApprovalEntry.Next() = 0;
// //             end;
// //             FormHeader.Status := FormHeader.Status::Open;
// //             FormHeader.Modify();
// //         end;
// //         Message('The Request has been Cancelled');
// //     end;

// //     procedure ReopenApprovalEntriesFM(FormHeader: Record "Form Header")
// //     var
// //         ApprovalEntry: Record "Approval Entry";
// //         UserSetUp: Record "User Setup";
// //         VoucherAdmin: Boolean;
// //     begin
// //         if not (FormHeader.Status = FormHeader.Status::Open) then
// //             exit;

// //         VoucherAdmin := false;
// //         UserSetUp.Reset();
// //         UserSetUp.SetRange(UserSetUp."User ID", UserId);
// //         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
// //         if UserSetUp.FindFirst() then begin
// //             VoucherAdmin := true;
// //         end;
// //         if (VoucherAdmin = true) then begin
// //             if (FormHeader.Status = FormHeader.Status::Open) then begin
// //                 ApprovalEntry.Reset();
// //                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
// //                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
// //                 if ApprovalEntry.FindFirst() then
// //                     repeat
// //                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
// //                         ApprovalEntry.Modify();
// //                     until ApprovalEntry.Next() = 0;
// //             end;
// //         end;
// //     end;
// //     //===============End Approval workflow mgt for Form Request================

// //     //Attachments =============
// //     //Document attachments for Maintenance Request
// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
// //     local procedure OnBeforeDrillDownDocMR(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         ADTRequisition: Record "Maintenance Header";
// //     begin
// //         case
// //         DocumentAttachment."Table ID" of
// //             Database::"Maintenance Header":
// //                 begin
// //                     RecRef.Open(Database::"Maintenance Header");
// //                     ADTRequisition.Reset();
// //                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
// //                     if ADTRequisition.FindFirst() then
// //                         RecRef.GetTable(ADTRequisition);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
// //     local procedure OnAfterOpenForRecRefDocMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
// //     var
// //         FRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         case RecRef.Number of
// //             Database::"Maintenance Header":
// //                 begin
// //                     FRef := RecRef.Field(1);
// //                     RecNo := FRef.Value;
// //                     DocumentAttachment.SetRange("No.", RecNo);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
// //     local procedure OnAfterInitFieldsFromRecRefMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         FieldRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         if RecRef.Number = Database::"Maintenance Header" then begin
// //             FieldRef := RecRef.Field(1);
// //             RecNo := FieldRef.Value();
// //             DocumentAttachment.Validate("No.", RecNo);
// //         end;
// //     end;

// //     //Document attachments for forms
// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
// //     local procedure OnBeforeDrillDownDocFM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         ADTRequisition: Record "Form Header";
// //     begin
// //         case
// //         DocumentAttachment."Table ID" of
// //             Database::"Form Header":
// //                 begin
// //                     RecRef.Open(Database::"Form Header");
// //                     ADTRequisition.Reset();
// //                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
// //                     if ADTRequisition.FindFirst() then
// //                         RecRef.GetTable(ADTRequisition);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
// //     local procedure OnAfterOpenForRecRefDocFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
// //     var
// //         FRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         case RecRef.Number of
// //             Database::"Form Header":
// //                 begin
// //                     FRef := RecRef.Field(1);
// //                     RecNo := FRef.Value;
// //                     DocumentAttachment.SetRange("No.", RecNo);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
// //     local procedure OnAfterInitFieldsFromRecRefPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         FieldRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         if RecRef.Number = Database::"Form Header" then begin
// //             FieldRef := RecRef.Field(1);
// //             RecNo := FieldRef.Value();
// //             DocumentAttachment.Validate("No.", RecNo);
// //         end;
// //     end;

// //     //Document attachments for Performance
// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
// //     local procedure OnBeforeDrillDownDocPM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         PerformanceHeader: Record "Performance Header";
// //     begin
// //         case
// //         DocumentAttachment."Table ID" of
// //             Database::"Performance Header":
// //                 begin
// //                     RecRef.Open(Database::"Performance Header");
// //                     PerformanceHeader.Reset();
// //                     PerformanceHeader.SetRange("No.", DocumentAttachment."No.");
// //                     if PerformanceHeader.FindFirst() then
// //                         RecRef.GetTable(PerformanceHeader);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
// //     local procedure OnAfterOpenForRecRefDocPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
// //     var
// //         FRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         case RecRef.Number of
// //             Database::"Performance Header":
// //                 begin
// //                     FRef := RecRef.Field(1);
// //                     RecNo := FRef.Value;
// //                     DocumentAttachment.SetRange("No.", RecNo);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
// //     local procedure OnAfterInitFieldsFromRecRefFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         FieldRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         if RecRef.Number = Database::"Performance Header" then begin
// //             FieldRef := RecRef.Field(1);
// //             RecNo := FieldRef.Value();
// //             DocumentAttachment.Validate("No.", RecNo);
// //         end;
// //     end;


// //     // Document Attachment Events for ADT Requisition Header
// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
// //     local procedure OnBeforeDrillDownDoc(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         ADTRequisition: Record "ADT Requisition Header";
// //     begin
// //         case
// //         DocumentAttachment."Table ID" of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     RecRef.Open(Database::"ADT Requisition Header");
// //                     ADTRequisition.Reset();
// //                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
// //                     if ADTRequisition.FindFirst() then
// //                         RecRef.GetTable(ADTRequisition);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
// //     local procedure OnAfterOpenForRecRefDoc(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
// //     var
// //         FRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         case RecRef.Number of
// //             Database::"ADT Requisition Header":
// //                 begin
// //                     FRef := RecRef.Field(3);
// //                     RecNo := FRef.Value;
// //                     DocumentAttachment.SetRange("No.", RecNo);
// //                 end;
// //         end;
// //     end;

// //     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
// //     local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
// //     var
// //         FieldRef: FieldRef;
// //         RecNo: Code[50];
// //     begin
// //         if RecRef.Number = Database::"ADT Requisition Header" then begin
// //             FieldRef := RecRef.Field(3);
// //             RecNo := FieldRef.Value();
// //             DocumentAttachment.Validate("No.", RecNo);
// //         end;
// //     end;

// //     //=====================================

// //     // update item ledger entry
// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
// //     local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
// //     begin
// //         ItemLedgerEntry."Equipment No." := ItemJournalLine."Equipment No.";
// //         ItemLedgerEntry."Equipment Type" := ItemJournalLine."Equipment Type";
// //         ItemLedgerEntry."Store Req. No" := ItemJournalLine."Store Req. No";
// //         ItemLedgerEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
// //         ItemLedgerEntry."Employee No." := ItemJournalLine."Employee No.";
// //         ItemLedgerEntry."From Store Req" := ItemJournalLine."From Store Req";
// //         ItemLedgerEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
// //         ItemLedgerEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
// //     local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
// //     begin
// //         ValueEntry."Equipment No." := ItemJournalLine."Equipment No.";
// //         ValueEntry."Equipment Type" := ItemJournalLine."Equipment Type";
// //         ValueEntry."Store Req. No" := ItemJournalLine."Store Req. No";
// //         ValueEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
// //         ValueEntry."Employee No." := ItemJournalLine."Employee No.";
// //         ValueEntry."From Store Req" := ItemJournalLine."From Store Req";
// //         ValueEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
// //         ValueEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitVendLedgEntry', '', false, false)]
// //     local procedure OnBeforeInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
// //     begin
// //         VendorLedgerEntry."Equipment No." := GenJournalLine."Equipment No.";
// //         VendorLedgerEntry."Equipment Type" := GenJournalLine."Equipment Type";
// //         VendorLedgerEntry."Responsible Employee" := GenJournalLine."Responsible Employee";
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeUpdatePurchaseHeader', '', false, false)]
// //     local procedure OnBeforeUpdatePurchaseHeader(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; GenJnlLineDocType: Option; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
// //     begin
// //         VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
// //         VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
// //         VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
// //         VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeItemJnlPostLine, '', false, false)]
// //     local procedure OnBeforeItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; var IsHandled: Boolean; WhseReceiptHeader: Record "Warehouse Receipt Header"; WhseShipmentHeader: Record "Warehouse Shipment Header"; TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary; TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
// //     begin
// //         ItemJournalLine."Equipment No." := PurchaseLine."Equipment No.";
// //         ItemJournalLine."Equipment Type" := PurchaseLine."Equipment Type";
// //         ItemJournalLine."Store Req. No" := PurchaseHeader."Purchase Requisition No.";
// //         ItemJournalLine."Responsible Employee" := PurchaseLine."Responsible Employee";
// //         ItemJournalLine."Purchase Requisition No." := PurchaseHeader."Purchase Requisition No.";
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
// //     local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; EverythingInvoiced: Boolean)
// //     Var
// //         VendorLedgerEntry: Record "Vendor Ledger Entry";
// //     begin
// //         if not PreviewMode then
// //             if PurchHeader."Document Type" in [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::Order] then begin
// //                 VendorLedgerEntry.Reset();
// //                 VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
// //                 if VendorLedgerEntry.FindFirst() then begin
// //                     VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
// //                     VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
// //                     VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
// //                     VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
// //                     VendorLedgerEntry.Modify();
// //                 end;
// //             end;
// //     end;

// //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
// //     local procedure AddCashPurchaseWorkflowResponses()
// //     var 
// //        WorkflowResponseHandling: Codeunit 1521;
// //        WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
// //     begin
// //         WorkflowResponseHandling.AddResponseToLibrary(
// //             'CASH_PURCHASE_APPROVE',
// //             DATABASE::"Cash Purchase",
// //             'Approve Cash Purchase',
// //             'GROUP 0');
// //     end;
// // }
// codeunit 50000 "Fleet Management"
// {
//     Permissions = tabledata "ADT Requisition Header" = rm,
//                       tabledata "ADT Requisition Line" = rm,
//                       tabledata "Email Related Attachment" = rm,
//                       tabledata "Vendor Ledger Entry" = rm,
//                       tabledata "Approval Entry" = rimd;
//     trigger OnRun()
//     begin

//     end;

//     var
//         Text0001: Label 'There is not enough space to insert extended text lines.';
//         GLAcc: Record "G/L Account";
//         Items: Record Item;
//         Res: Record Resource;
//         TmpExtTextLine: Record "Extended Text Line" temporary;
//         NextLineNo: Integer;
//         LineSpacing: Integer;
//         MakeUpdateRequired: Boolean;
//         AutoText: Boolean;

//         Text000: Label 'Firm Planned %1';
//         Text001: Label 'Released %1';
//         Text003: Label 'CU99000845: CalculateRemainingQty - Source type missing';
//         Text004: Label 'Codeunit 99000845: Illegal FieldFilter parameter';
//         Text006: Label 'Outbound,Inbound';
//         Text007: Label 'CU99000845 DeleteReserveEntries2: Surplus order tracking double record detected.';
//         CalcReservEntry: Record "Reservation Entry";
//         CalcReservEntry2: Record "Reservation Entry";
//         ForItemLedgEntry: Record "Item Ledger Entry";
//         CalcItemLedgEntry: Record "Item Ledger Entry";
//         ForSalesLine: Record "Sales Line";
//         CalcSalesLine: Record "Sales Line";
//         ForPurchLine: Record "Purchase Line";
//         CalcPurchLine: Record "Purchase Line";
//         ForItemJnlLine: Record "Item Journal Line";
//         ForReqLine: Record "Requisition Line";
//         CalcReqLine: Record "Requisition Line";
//         ForProdOrderLine: Record "Prod. Order Line";
//         CalcProdOrderLine: Record "Prod. Order Line";
//         ForProdOrderComp: Record "Prod. Order Component";
//         CalcProdOrderComp: Record "Prod. Order Component";
//         ForPlanningComponent: Record "Planning Component";
//         CalcPlanningComponent: Record "Planning Component";
//         ForAssemblyHeader: Record "Assembly Header";
//         CalcAssemblyHeader: Record "Assembly Header";
//         ForAssemblyLine: Record "Assembly Line";
//         CalcAssemblyLine: Record "Assembly Line";
//         ForTransLine: Record "Transfer Line";
//         CalcTransLine: Record "Transfer Line";
//         ForServiceLine: Record "Service Line";
//         CalcServiceLine: Record "Service Line";
//         ForJobPlanningLine: Record "Job Planning Line";
//         CalcJobPlanningLine: Record "Job Planning Line";
//         ActionMessageEntry: Record "Action Message Entry";
//         Item: Record "Item";
//         Location: Record "Location";
//         MfgSetup: Record "Manufacturing Setup";
//         SKU: Record "Stockkeeping Unit";
//         ItemTrackingCode: Record "Item Tracking Code";
//         TempTrackingSpecification: Record "Tracking Specification" temporary;
//         CallTrackingSpecification: Record "Tracking Specification";
//         ForJobJnlLine: Record "Job Journal Line";
//         CreateReservEntry: Codeunit "Create Reserv. Entry";
//         ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
//         ReserveSalesLine: Codeunit "Sales Line-Reserve";
//         ReserveReqLine: Codeunit "Req. Line-Reserve";
//         ReservePurchLine: Codeunit "Purch. Line-Reserve";
//         ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
//         ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
//         ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
//         AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
//         AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
//         ReservePlanningComponent: Codeunit "Plng. Component-Reserve";
//         ReserveServiceInvLine: Codeunit "Service Line-Reserve";
//         ReserveTransLine: Codeunit "Transfer Line-Reserve";
//         JobPlanningLineReserve: Codeunit "Job Planning Line-Reserve";
//         GetPlanningParameters: Codeunit "Planning-Get Parameters";
//         CreatePick: Codeunit "Create Pick";
//         Positive: Boolean;
//         CurrentBindingIsSet: Boolean;
//         HandleItemTracking: Boolean;
//         InvSearch: Text[1];
//         FieldFilter: Text[80];
//         InvNextStep: Integer;
//         ValueArray: array[18] of Integer;
//         CurrentBinding: Option "Order-to-Order";
//         ItemTrackingHandling: Option "None","Allow deletion",Match;
//         Text008: Label 'Item tracking defined for item %1 in the %2 accounts for more than the quantity you have entered.\You must adjust the existing item tracking and then reenter the new quantity.';
//         Text009: Label 'Item Tracking cannot be fully matched.\Serial No.: %1, Lot No.: %2, outstanding quantity: %3.';
//         Text010: Label 'Item tracking is defined for item %1 in the %2.\You must delete the existing item tracking before modifying or deleting the %2.';
//         TotalAvailQty: Decimal;
//         QtyAllocInWhse: Decimal;
//         QtyOnOutBound: Decimal;
//         Text011: Label 'Item tracking is defined for item %1 in the %2.\Do you want to delete the %2 and the item tracking lines?';
//         QtyReservedOnPickShip: Decimal;
//         Text012: Label 'Assembly';
//         "==CMM==": Integer;
//         ForNFLReqLine: Record "ADT Requisition Line";
//         // ReserveNFLReqLine: Codeunit "Req-Line Reserve2";

//         //=============PurchInfoPaneMgt=================
//         Vend: Record Vendor;
//         PurchHeader: Record "ADT Requisition Header";
//         Text00011: Label 'The Ship-to Address has been changed.';

//         //Cash Purchase
//         CashPurchase: Record "Cash Purchase";

//         //==========================NFL Purch. Price Calc. Mgt.=======================
//         //============================================================================
//         GLSetup: Record "General Ledger Setup";
//         ResCost: Record "Resource Cost";
//         Currency: Record Currency;
//         TempPurchPrice: Record "Purchase Price" temporary;
//         TempPurchLineDisc: Record "Purchase Line Discount" temporary;
//         ResFindUnitCost: Codeunit "Resource-Find Cost";
//         LineDiscPerCent: Decimal;
//         Qty: Decimal;
//         QtyPerUOM: Decimal;
//         VATPerCent: Decimal;
//         PricesInclVAT: Boolean;
//         VATBusPostingGr: Code[10];
//         PricesInCurrency: Boolean;
//         PriceInSKU: Boolean;
//         CurrencyFactor: Decimal;
//         ExchRateDate: Date;
//         FoundPurchPrice: Boolean;
//         DateCaption: Text[30];
//         Text020: Label '%1 is less than %2 in the %3.';
//         Text030: Label 'Cost including VAT cannot be calculated when %1 is %2.';
//         Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
//         Text040: Label 'The %1 in the %2 must be same as in the %3.';
//         RecRef: RecordRef;

//         //========Approval Workflow Management========
//         WorkflowManagementPRQ: Codeunit 1501;
//         WorkflowEventHandlingCustPRQ: Codeunit "Workflow EventHandling Ext";
//         NoWorkflowEnabledErrPRQ: TextConst ENU = 'No Approval Workflow for the type is enabled';

//         //========Approval Workflow Management========
//         WorkflowManagementMR: Codeunit 1501;
//         WorkflowEventHandlingCustMR: Codeunit "Workflow EventHandling Ext";
//         NoWorkflowEnabledErrMR: TextConst ENU = 'No Approval Workflow for the type is enabled';

//         //================form approval===
//         WorkflowManagementFM: Codeunit 1501;
//         WorkflowEventHandlingCustFM: Codeunit "Workflow EventHandling Ext";
//         NoWorkflowEnabledErrFM: TextConst ENU = 'No Approval Workflow for the type is enabled';

//         //================Cash Purchase approval===
//         WorkflowManagementCP: Codeunit 1501;
//         WorkflowEventHandlingCustCP: Codeunit "Workflow EventHandling Ext";
//         NoWorkflowEnabledErrCP: TextConst ENU = 'No Approval Workflow for the type is enabled';

//     /// <summary>
//     /// EditDimensionSet2.
//     /// </summary>
//     procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]): Integer
//     var
//         EditDimSetEntries: Page "Edit Dimension Set Entries";
//         NewDimSetID: Integer;
//         DimSetEntry: Record "Dimension Set Entry";
//         dimensionMgt: Codeunit DimensionManagement;
//     begin
//         NewDimSetID := DimSetID;
//         DimSetEntry.RESET;
//         DimSetEntry.FILTERGROUP(2);
//         DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
//         DimSetEntry.FILTERGROUP(0);
//         EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
//         EditDimSetEntries.SetFormCaption(NewCaption);
//         EditDimSetEntries.RUNMODAL;
//         NewDimSetID := EditDimSetEntries.GetDimensionID;
//         dimensionMgt.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
//         DimSetEntry.RESET;
//         EXIT(NewDimSetID);
//     end;

//     procedure TotalControlsUpdateStyle(RefreshMessageEnabled: Boolean; VAR ControlStyle: Text; VAR RefreshMessageText: Text)
//     var
//         RefreshMsgTxt: TextConst ENU = 'Totals or discounts may not be up-to-date. Choose the link to update.';
//     begin
//         IF RefreshMessageEnabled THEN BEGIN
//             ControlStyle := 'Subordinate';
//             RefreshMessageText := RefreshMsgTxt;
//         END ELSE BEGIN
//             ControlStyle := 'Strong';
//             RefreshMessageText := '';
//         END;
//     end;

//     procedure CreateBookAndOpenExcel(SheetName: Text[250]; ReportHeader: Text[80]; CompanyName: Text[30]; UserID2: Text)
//     var
//         ExcelBuffer: Record "Excel Buffer";
//     begin
//         ExcelBuffer.WriteSheet(ReportHeader, CompanyName, UserID2);
//         ExcelBuffer.CloseBook;
//         ExcelBuffer.OpenExcel;
//     end;

//     procedure TransferQty()
//     var
//         PurchaseRequisitionLines: Record "ADT Requisition Line";
//     begin
//         PurchaseRequisitionLines.Reset();
//         PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
//         if PurchaseRequisitionLines.FindFirst() then
//             repeat
//                 PurchaseRequisitionLines."Save Qty. to Order" := PurchaseRequisitionLines.Quantity;
//                 PurchaseRequisitionLines.Modify();
//             until PurchaseRequisitionLines.Next() = 0;
//     end;

//     procedure FillinQtyToOrder()
//     var
//         PurchaseRequisitionLines: Record "ADT Requisition Line";
//     begin
//         PurchaseRequisitionLines.Reset();
//         PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
//         if PurchaseRequisitionLines.FindFirst() then
//             repeat
//                 PurchaseRequisitionLines."Qty. to Order" := PurchaseRequisitionLines."Save Qty. to Order";
//                 PurchaseRequisitionLines.Modify();
//             until PurchaseRequisitionLines.Next() = 0;
//     end;

//     procedure PurchCheckIfAnyExtText(var PurchLine: Record "ADT Requisition Line"; Unconditionally: Boolean): Boolean;
//     var
//         PurchHeader: Record "ADT Requisition Header";
//         ExtTextHeader: Record "Extended Text Header";
//     begin
//         MakeUpdateRequired := FALSE;
//         IF PurchLine."Line No." <> 0 THEN
//             MakeUpdateRequired := DeletePurchLines(PurchLine);

//         AutoText := FALSE;

//         IF Unconditionally THEN
//             AutoText := TRUE
//         ELSE
//             CASE PurchLine.Type OF
//                 PurchLine.Type::" ":
//                     AutoText := TRUE;
//                 PurchLine.Type::"G/L Account":
//                     BEGIN
//                         IF GLAcc.GET(PurchLine."No.") THEN
//                             AutoText := GLAcc."Automatic Ext. Texts";
//                     END;
//                 PurchLine.Type::Item:
//                     BEGIN
//                         IF Items.GET(PurchLine."No.") THEN
//                             AutoText := Items."Automatic Ext. Texts";
//                     END;
//             END;

//         IF AutoText THEN BEGIN
//             PurchLine.TESTFIELD("Document No.");
//             PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
//             ExtTextHeader.SETRANGE("Table Name", PurchLine.Type);
//             ExtTextHeader.SETRANGE("No.", PurchLine."No.");
//             CASE PurchLine."Document Type" OF
//                 PurchLine."Document Type"::"Store Requisition":
//                     ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
//                 PurchLine."Document Type"::"Purchase Requisition":
//                     ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
//             END;
//             EXIT(ReadLines(ExtTextHeader, PurchHeader."Document Date", PurchHeader."Language Code"));
//         END;
//     end;

//     procedure InsertPurchExtText(var PurchLine: Record "ADT Requisition Line");
//     var
//         ToPurchLine: Record "ADT Requisition Line";
//     begin
//         ToPurchLine.RESET;
//         ToPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
//         ToPurchLine.SETRANGE("Document No.", PurchLine."Document No.");
//         ToPurchLine := PurchLine;
//         IF ToPurchLine.FIND('>') THEN BEGIN
//             LineSpacing :=
//               (ToPurchLine."Line No." - PurchLine."Line No.") DIV
//               (1 + TmpExtTextLine.COUNT);
//             IF LineSpacing = 0 THEN
//                 ERROR(Text0001);
//         END ELSE
//             LineSpacing := 10000;

//         NextLineNo := PurchLine."Line No." + LineSpacing;

//         TmpExtTextLine.RESET;
//         IF TmpExtTextLine.FIND('-') THEN BEGIN
//             REPEAT
//                 ToPurchLine.INIT;
//                 ToPurchLine."Document Type" := PurchLine."Document Type";
//                 ToPurchLine."Document No." := PurchLine."Document No.";
//                 ToPurchLine."Line No." := NextLineNo;
//                 NextLineNo := NextLineNo + LineSpacing;
//                 ToPurchLine.Description := TmpExtTextLine.Text;
//                 ToPurchLine."Attached to Line No." := PurchLine."Line No.";
//                 ToPurchLine.INSERT;
//             UNTIL TmpExtTextLine.NEXT = 0;
//             MakeUpdateRequired := TRUE;
//         END;
//         TmpExtTextLine.DELETEALL;
//     end;

//     procedure DeletePurchLines(var PurchLine: Record "ADT Requisition Line"): Boolean;
//     var
//         PurchLine2: Record "ADT Requisition Line";
//     begin
//         PurchLine2.SETRANGE("Document Type", PurchLine."Document Type");
//         PurchLine2.SETRANGE("Document No.", PurchLine."Document No.");
//         PurchLine2.SETRANGE("Attached to Line No.", PurchLine."Line No.");
//         PurchLine2 := PurchLine;
//         IF PurchLine2.FIND('>') THEN BEGIN
//             REPEAT
//                 PurchLine2.DELETE(TRUE);
//             UNTIL PurchLine2.NEXT = 0;
//             EXIT(TRUE);
//         END;
//     end;

//     procedure MakeUpdate(): Boolean;
//     begin
//         EXIT(MakeUpdateRequired);
//     end;

//     local procedure ReadLines(var ExtTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]): Boolean;
//     var
//         ExtTextLine: Record "Extended Text Line";
//     begin
//         ExtTextHeader.SETCURRENTKEY(
//           "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
//         ExtTextHeader.SETRANGE("Starting Date", 0D, DocDate);
//         ExtTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
//         IF LanguageCode = '' THEN BEGIN
//             ExtTextHeader.SETRANGE("Language Code", '');
//             IF NOT ExtTextHeader.FIND('+') THEN
//                 EXIT;
//         END ELSE BEGIN
//             ExtTextHeader.SETRANGE("Language Code", LanguageCode);
//             IF NOT ExtTextHeader.FIND('+') THEN BEGIN
//                 ExtTextHeader.SETRANGE("All Language Codes", TRUE);
//                 ExtTextHeader.SETRANGE("Language Code", '');
//                 IF NOT ExtTextHeader.FIND('+') THEN
//                     EXIT;
//             END;
//         END;

//         ExtTextLine.SETRANGE("Table Name", ExtTextHeader."Table Name");
//         ExtTextLine.SETRANGE("No.", ExtTextHeader."No.");
//         ExtTextLine.SETRANGE("Language Code", ExtTextHeader."Language Code");
//         ExtTextLine.SETRANGE("Text No.", ExtTextHeader."Text No.");
//         IF ExtTextLine.FIND('-') THEN BEGIN
//             TmpExtTextLine.DELETEALL;
//             REPEAT
//                 TmpExtTextLine := ExtTextLine;
//                 TmpExtTextLine.INSERT;
//             UNTIL ExtTextLine.NEXT = 0;
//             EXIT(TRUE);
//         END;
//     end;

//     procedure SetRequisitionLine(NewReqLine: Record "ADT Requisition Line")
//     var
//         CalcReserveEntry: Record "Reservation Entry";
//         CalcReserveEntry2: Record "Reservation Entry";
//         ForItemLedgEntry: Record "Item Ledger Entry";
//         CalcItemLedgEntry: Record "Item Ledger Entry";
//         ForSalesLine: Record "Sales Line";
//         CalcSalesLine: Record "Sales Line";
//         ForPurchLine: Record "Purchase Line";
//         CalcPurchLine: Record "Purchase Line";
//         ForItemJnlLine: Record "Item Journal Line";
//         ForReqLine: Record "Requisition Line";
//         CalcReqLine: Record "Requisition Line";
//         ForProdOrderLine: Record "Prod. Order Line";
//         CalcProdOrderLine: Record "Prod. Order Line";
//         ForProdOrderComp: Record "Prod. Order Component";
//         CalcProdOrderComp: Record "Prod. Order Component";
//         ForPlanningComponent: Record "Planning Component";
//         CalcPlanningComponent: Record "Planning Component";
//         ForAssemblyHeader: Record "Assembly Header";
//         CalcAssemblyHeader: Record "Assembly Header";
//         ForAssemblyLine: Record "Assembly Line";
//         CalcAssemblyLine: Record "Assembly Line";
//         ForTransLine: Record "Transfer Line";
//         CalcTransLine: Record "Transfer Line";
//         ForServiceLine: Record "Service Line";
//         CalcServiceLine: Record "Service Line";
//         ForJobPlanningLine: Record "Job Planning Line";
//         CalcJobPlanningLine: Record "Job Planning Line";
//         ActionMessageEntry: Record "Action Message Entry";
//         ForNFLReqLine: Record "ADT Requisition Line";
//         Location: Record Location;
//         TempTrackingSpecification: Record "Tracking Specification";
//         ReservationManagement: Codeunit "Reservation Management";
//     begin
//         CLEARALL;
//         TempTrackingSpecification.DELETEALL;

//         ForNFLReqLine := NewReqLine;

//         CalcReserveEntry."Source Subtype" := ForNFLReqLine."Document Type";
//         CalcReserveEntry."Source ID" := NewReqLine."Document No.";
//         CalcReserveEntry."Source Ref. No." := NewReqLine."Line No.";

//         IF NewReqLine.Type = NewReqLine.Type::Item THEN
//             CalcReserveEntry."Item No." := NewReqLine."No.";
//         CalcReserveEntry."Variant Code" := NewReqLine."Variant Code";
//         CalcReserveEntry."Location Code" := NewReqLine."Location Code";
//         CalcReserveEntry."Serial No." := '';
//         CalcReserveEntry."Lot No." := '';
//         CalcReserveEntry."Qty. per Unit of Measure" := NewReqLine."Qty. per Unit of Measure";
//         CalcReserveEntry."Expected Receipt Date" := NewReqLine."Planned Receipt Date";
//         CalcReserveEntry."Shipment Date" := NewReqLine."Planned Receipt Date";
//         CalcReserveEntry.Description := NewReqLine.Description;
//         CalcReserveEntry2 := CalcReserveEntry;
//         IF (CalcReserveEntry."Location Code" <> '') AND
//            Location.GET(CalcReserveEntry."Location Code") AND
//            (Location."Bin Mandatory" OR Location."Require Pick")
//         THEN;
//     end;

//     procedure PurchaseLines(PurchaseHeader: Record "Purchase Header"): Boolean;
//     var
//         PurchaseLines: Record "Purchase Line";
//     begin
//         WITH PurchaseLines DO BEGIN
//             SETCURRENTKEY("Document Type", "Document No.");
//             SETRANGE("Document Type", PurchaseHeader."Document Type");
//             SETRANGE("Document No.", PurchaseHeader."No.");
//             IF FINDSET THEN
//                 REPEAT
//                     IF (Quantity <> 0) AND ("Line Amount" <> 0) THEN
//                         EXIT(TRUE);
//                 UNTIL NEXT = 0;
//         END;
//         EXIT(FALSE);
//     end;

//     procedure CalcNoOfDocuments(var Vend: Record Vendor);
//     begin
//         Vend.CALCFIELDS(
//           "No. of Quotes", "No. of Blanket Orders", "No. of Orders", "No. of Invoices",
//           "No. of Return Orders", "No. of Credit Memos", "No. of Pstd. Return Shipments", "No. of Pstd. Invoices",
//           "No. of Pstd. Receipts", "No. of Pstd. Credit Memos",
//           "Buy-from No. Of Archived Doc.");
//     end;

//     procedure CalcTotalNoOfDocuments(VendNo: Code[20]): Integer;
//     begin
//         GetVend(VendNo);
//         WITH Vend DO BEGIN
//             CalcNoOfDocuments(Vend);
//             EXIT(
//               "No. of Quotes" + "No. of Blanket Orders" + "No. of Orders" + "No. of Invoices" +
//               "No. of Return Orders" + "No. of Credit Memos" +
//               "No. of Pstd. Receipts" + "No. of Pstd. Invoices" +
//               "No. of Pstd. Return Shipments" + "No. of Pstd. Credit Memos" +
//               "Buy-from No. Of Archived Doc.");
//         END;
//     end;

//     procedure CalcNoOfOrderAddr(VendNo: Code[20]): Integer;
//     begin
//         GetVend(VendNo);
//         Vend.CALCFIELDS("No. of Order Addresses");
//         EXIT(Vend."No. of Order Addresses");
//     end;

//     procedure CalcNoOfContacts(PurchHeader: Record "ADT Requisition Header"): Integer;
//     var
//         Cont: Record Contact;
//         ContBusRelation: Record "Contact Business Relation";
//     begin
//         Cont.SETCURRENTKEY("Company No.");
//         WITH PurchHeader DO
//             IF "Buy-from Vendor No." <> '' THEN BEGIN
//                 IF Cont.GET("Buy-from Contact No.") THEN BEGIN
//                     Cont.SETRANGE("Company No.", Cont."Company No.");
//                     EXIT(Cont.COUNT);
//                 END ELSE BEGIN
//                     ContBusRelation.RESET;
//                     ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
//                     ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
//                     ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
//                     IF ContBusRelation.FINDFIRST THEN BEGIN
//                         Cont.SETRANGE("Company No.", ContBusRelation."Contact No.");
//                         EXIT(Cont.COUNT);
//                     END ELSE
//                         EXIT(0)
//                 END;
//             END;
//     end;

//     procedure CalcNoOfSubstitutions(var PurchLine: Record "ADT Requisition Line"): Integer;
//     begin
//         IF GetItem(PurchLine) THEN BEGIN
//             Item.CALCFIELDS("No. of Substitutes");
//             EXIT(Item."No. of Substitutes");
//         END;
//     end;

//     procedure CalcNoOfPurchasePrices(var PurchLine: Record "ADT Requisition Line"): Integer;
//     begin
//         IF GetItem(PurchLine) THEN BEGIN
//             GetPurchHeader(PurchLine);
//             EXIT(NoOfPurchLinePrice(PurchHeader, PurchLine, TRUE));
//         END;
//     end;

//     procedure CalcNoOfPurchLineDisc(var PurchLine: Record "ADT Requisition Line"): Integer;
//     begin
//         IF GetItem(PurchLine) THEN BEGIN
//             GetPurchHeader(PurchLine);
//             EXIT(NoOfPurchLineLineDisc(PurchHeader, PurchLine, TRUE));
//         END;
//     end;

//     procedure DocExist(CurrentPurchHeader: Record "ADT Requisition Header"; VendNo: Code[20]): Boolean;
//     var
//         PurchInvHeader: Record "Purch. Inv. Header";
//         PurchRcptHeader: Record "Purch. Rcpt. Header";
//         PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
//         ReturnShipment: Record "Return Shipment Header";
//         PurchHeader: Record "ADT Requisition Header";
//     begin
//         IF VendNo = '' THEN
//             EXIT(FALSE);
//         WITH PurchInvHeader DO BEGIN
//             SETCURRENTKEY("Buy-from Vendor No.");
//             SETRANGE("Buy-from Vendor No.", VendNo);
//             IF NOT ISEMPTY THEN
//                 EXIT(TRUE);
//         END;
//         WITH PurchRcptHeader DO BEGIN
//             SETCURRENTKEY("Buy-from Vendor No.");
//             SETRANGE("Buy-from Vendor No.", VendNo);
//             IF NOT ISEMPTY THEN
//                 EXIT(TRUE);
//         END;
//         WITH PurchCrMemoHeader DO BEGIN
//             SETCURRENTKEY("Buy-from Vendor No.");
//             SETRANGE("Buy-from Vendor No.", VendNo);
//             IF NOT ISEMPTY THEN
//                 EXIT(TRUE);
//         END;
//         WITH PurchHeader DO BEGIN
//             SETCURRENTKEY("Buy-from Vendor No.");
//             SETRANGE("Buy-from Vendor No.", VendNo);
//             IF FINDFIRST THEN BEGIN
//                 IF ("Document Type" <> CurrentPurchHeader."Document Type") OR
//                    ("No." <> CurrentPurchHeader."No.")
//                 THEN
//                     EXIT(TRUE);
//                 IF FIND('>') THEN
//                     EXIT(TRUE);
//             END;
//         END;
//         WITH ReturnShipment DO BEGIN
//             SETCURRENTKEY("Buy-from Vendor No.");
//             SETRANGE("Buy-from Vendor No.", VendNo);
//             IF NOT ISEMPTY THEN
//                 EXIT(TRUE);
//         END;
//     end;

//     procedure VendCommentExists(VendNo: Code[20]): Boolean;
//     begin
//         GetVend(VendNo);
//         Vend.CALCFIELDS(Comment);
//         EXIT(Vend.Comment);
//     end;

//     procedure ItemCommentExists(var PurchLine: Record "ADT Requisition Line"): Boolean;
//     begin
//         IF GetItem(PurchLine) THEN BEGIN
//             Item.CALCFIELDS(Comment);
//             EXIT(Item.Comment);
//         END;
//     end;

//     procedure LookupOrderAddr(var PurchHeader: Record "ADT Requisition Header");
//     var
//         OrderAddress: Record "Order Address";
//     begin
//         WITH PurchHeader DO BEGIN
//             OrderAddress.SETRANGE("Vendor No.", "Buy-from Vendor No.");
//             IF PAGE.RUNMODAL(0, OrderAddress) = ACTION::LookupOK THEN BEGIN
//                 VALIDATE("Order Address Code", OrderAddress.Code);
//                 MODIFY(TRUE);
//                 MESSAGE(Text00011);
//             END;
//         END;
//     end;

//     procedure LookupContacts(var PurchHeader: Record "ADT Requisition Header");
//     var
//         Cont: Record Contact;
//         ContBusRelation: Record "Contact Business Relation";
//     begin
//         WITH PurchHeader DO BEGIN
//             IF "Buy-from Vendor No." <> '' THEN BEGIN
//                 IF Cont.GET("Buy-from Contact No.") THEN
//                     Cont.SETRANGE("Company No.", Cont."Company No.")
//                 ELSE BEGIN
//                     ContBusRelation.RESET;
//                     ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
//                     ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
//                     ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
//                     IF ContBusRelation.FINDFIRST THEN
//                         Cont.SETRANGE("Company No.", ContBusRelation."Contact No.")
//                     ELSE
//                         Cont.SETRANGE("No.", '');
//                 END;

//                 IF Cont.GET("Buy-from Contact No.") THEN;
//             END ELSE
//                 Cont.SETRANGE("No.", '');
//             IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
//                 VALIDATE("Buy-from Contact No.", Cont."No.");
//                 MODIFY(TRUE);
//             END;
//         END;
//     end;

//     procedure LookupItem(PurchLine: Record "ADT Requisition Line");
//     begin
//         PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
//         PurchLine.TESTFIELD("No.");
//         GetItem(PurchLine);
//         PAGE.RUNMODAL(PAGE::"Item Card", Item);
//     end;

//     procedure LookupItemComment(PurchLine: Record "ADT Requisition Line");
//     var
//         CommentLine: Record "Comment Line";
//     begin
//         IF GetItem(PurchLine) THEN BEGIN
//             CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
//             CommentLine.SETRANGE("No.", PurchLine."No.");
//             PAGE.RUNMODAL(PAGE::"Comment Sheet", CommentLine);
//         END;
//     end;

//     local procedure GetVend(VendNo: Code[20]);
//     begin
//         IF VendNo <> '' THEN BEGIN
//             IF VendNo <> Vend."No." THEN
//                 IF NOT Vend.GET(VendNo) THEN
//                     CLEAR(Vend);
//         END ELSE
//             CLEAR(Vend);
//     end;

//     local procedure GetItem(var PurchLine: Record "ADT Requisition Line"): Boolean;
//     begin
//         WITH Item DO BEGIN
//             IF (PurchLine.Type <> PurchLine.Type::Item) OR (PurchLine."No." = '') THEN
//                 EXIT(FALSE);

//             IF PurchLine."No." <> "No." THEN
//                 GET(PurchLine."No.");
//             EXIT(TRUE);
//         END;
//     end;

//     local procedure GetPurchHeader(PurchLine: Record "ADT Requisition Line");
//     begin
//         IF (PurchLine."Document Type" <> PurchHeader."Document Type") OR
//            (PurchLine."Document No." <> PurchHeader."No.")
//         THEN
//             PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
//     end;

//     procedure CalcNoOfPayToDocuments(var Vend: Record Vendor);
//     begin
//         Vend.CALCFIELDS(
//           "Pay-to No. of Quotes", "Pay-to No. of Blanket Orders", "Pay-to No. of Orders", "Pay-to No. of Invoices",
//           "Pay-to No. of Return Orders", "Pay-to No. of Credit Memos", "Pay-to No. of Pstd. Receipts",
//           "Pay-to No. of Pstd. Invoices", "Pay-to No. of Pstd. Return S.", "Pay-to No. of Pstd. Cr. Memos",
//           "Pay-to No. Of Archived Doc.");
//     end;

//     procedure CalcAvailability2(var PurchLine: Record "ADT Requisition Line"): Decimal;
//     var
//         AvailableToPromise: Codeunit "Available to Promise";
//         GrossRequirement: Decimal;
//         ScheduledReceipt: Decimal;
//         PeriodType: Option Day,Week,Month,Quarter,Year;
//         AvailabilityDate: Date;
//         LookaheadDateFormula: DateFormula;
//         lvItemLedgEntry: Record "Item Ledger Entry";
//         lvInvtQty: Decimal;
//         lvReservEntry: Record "Reservation Entry";
//         lvReservedQty: Decimal;
//     begin
//         lvInvtQty := 0;
//         IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
//             lvItemLedgEntry.RESET;
//             lvItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
//             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Item No.", PurchLine."No.");
//             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Variant Code", PurchLine."Variant Code");
//             lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Location Code", PurchLine."Location Code");
//             lvItemLedgEntry.CALCSUMS(lvItemLedgEntry.Quantity);
//             lvInvtQty := lvItemLedgEntry.Quantity;

//             lvReservEntry.SETCURRENTKEY("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code");
//             lvReservEntry.SETRANGE(lvReservEntry."Item No.", PurchLine."No.");
//             lvReservEntry.SETFILTER(lvReservEntry."Source Type", '%1', 32);
//             lvReservEntry.SETFILTER(lvReservEntry."Source Subtype", '%1', 0);
//             lvReservEntry.SETFILTER(lvReservEntry."Reservation Status", '%1', lvReservEntry."Reservation Status"::Reservation);
//             lvReservEntry.SETRANGE(lvReservEntry."Location Code", PurchLine."Location Code");
//             lvReservEntry.SETRANGE(lvReservEntry."Variant Code", PurchLine."Variant Code");
//             lvReservEntry.CALCSUMS(lvReservEntry."Quantity (Base)");
//             lvReservedQty := lvReservEntry."Quantity (Base)";
//             EXIT(lvInvtQty - lvReservedQty);
//         END
//         ELSE
//             EXIT(lvInvtQty);
//     end;

//     procedure FindPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; CalledByFieldNo: Integer);
//     begin
//         WITH PurchLine DO BEGIN
//             SetCurrency(
//               PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));
//             SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
//             SetLineDisc("Line Discount %");

//             TESTFIELD("Qty. per Unit of Measure");
//             IF PricesInCurrency THEN
//                 PurchHeader.TESTFIELD("Currency Factor");

//             CASE Type OF
//                 Type::Item:
//                     BEGIN
//                         Item.GET("No.");
//                         PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

//                         PurchLinePriceExists(PurchHeader, PurchLine, FALSE);
//                         CalcBestDirectUnitCost(TempPurchPrice);

//                         IF FoundPurchPrice OR
//                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//                         THEN
//                             "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
//                     END;
//             END;
//         END;
//     end;

//     procedure FindItemJnlLinePrice(var ItemJnlLine: Record "Item Journal Line"; CalledByFieldNo: Integer);
//     begin
//         WITH ItemJnlLine DO BEGIN
//             TESTFIELD("Qty. per Unit of Measure");
//             SetCurrency('', 0, 0D);
//             SetVAT(FALSE, 0, '');
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             Item.GET("Item No.");
//             PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

//             FindPurchPrice(
//               TempPurchPrice, '', "Item No.", "Variant Code",
//               "Unit of Measure Code", '', "Posting Date", FALSE);
//             CalcBestDirectUnitCost(TempPurchPrice);

//             IF FoundPurchPrice OR
//                NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                     (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//             THEN
//                 "Unit Amount" := TempPurchPrice."Direct Unit Cost";
//         END;
//     end;

//     procedure FindReqLinePrice(var ReqLine: Record "Requisition Line"; CalledByFieldNo: Integer);
//     begin
//         WITH ReqLine DO BEGIN
//             IF Type = Type::Item THEN BEGIN
//                 IF NOT Vend.GET("Vendor No.") THEN
//                     Vend.INIT;

//                 SetCurrency("Currency Code", "Currency Factor", "Order Date");
//                 SetVAT(Vend."Prices Including VAT", 0, '');
//                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//                 TESTFIELD("Qty. per Unit of Measure");
//                 IF PricesInCurrency THEN
//                     ReqLine.TESTFIELD("Currency Factor");

//                 Item.GET("No.");
//                 PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

//                 FindPurchPrice(
//                   TempPurchPrice, "Vendor No.", "No.", "Variant Code",
//                   "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
//                 CalcBestDirectUnitCost(TempPurchPrice);

//                 IF FoundPurchPrice OR
//                    NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                         (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//                 THEN
//                     "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
//             END;
//         END;
//     end;

//     procedure FindPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
//     begin
//         WITH PurchLine DO BEGIN
//             SetCurrency(PurchHeader."Currency Code", 0, 0D);
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             TESTFIELD("Qty. per Unit of Measure");

//             IF PurchLine.Type = Type::Item THEN BEGIN
//                 PurchLineLineDiscExists(PurchHeader, PurchLine, FALSE);
//                 CalcBestLineDisc(TempPurchLineDisc);

//                 "Line Discount %" := TempPurchLineDisc."Line Discount %";
//             END;
//         END;
//     end;

//     procedure FindStdItemJnlLinePrice(var StdItemJnlLine: Record "Standard Item Journal Line"; CalledByFieldNo: Integer);
//     begin
//         WITH StdItemJnlLine DO BEGIN
//             TESTFIELD("Qty. per Unit of Measure");
//             SetCurrency('', 0, 0D);
//             SetVAT(FALSE, 0, '');
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             Item.GET("Item No.");
//             PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

//             FindPurchPrice(
//               TempPurchPrice, '', "Item No.", "Variant Code",
//               "Unit of Measure Code", '', WORKDATE, FALSE);
//             CalcBestDirectUnitCost(TempPurchPrice);

//             IF FoundPurchPrice OR
//                NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                     (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//             THEN
//                 "Unit Amount" := TempPurchPrice."Direct Unit Cost";
//         END;
//     end;

//     procedure FindReqLineDisc(var ReqLine: Record "Requisition Line");
//     begin
//         WITH ReqLine DO BEGIN
//             SetCurrency("Currency Code", 0, 0D);
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             TESTFIELD("Qty. per Unit of Measure");

//             IF ReqLine.Type = Type::Item THEN BEGIN
//                 FindPurchLineDisc(
//                   TempPurchLineDisc, "Vendor No.", "No.", "Variant Code",
//                   "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
//                 CalcBestLineDisc(TempPurchLineDisc);

//                 "Line Discount %" := TempPurchLineDisc."Line Discount %";
//             END;
//         END;
//     end;

//     local procedure CalcBestDirectUnitCost(var PurchPrice: Record "Purchase Price");
//     var
//         BestPurchPrice: Record "Purchase Price";
//     begin
//         WITH PurchPrice DO BEGIN
//             FoundPurchPrice := PurchPrice.FIND('-');
//             IF FoundPurchPrice THEN
//                 REPEAT
//                     IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
//                         ConvertPriceToVAT(
//                           Vend."Prices Including VAT", Item."VAT Prod. Posting Group",
//                           Vend."VAT Bus. Posting Group", "Direct Unit Cost");
//                         ConvertPriceToUoM("Unit of Measure Code", "Direct Unit Cost");
//                         ConvertPriceLCYToFCY("Currency Code", "Direct Unit Cost");

//                         CASE TRUE OF
//                             ((BestPurchPrice."Currency Code" = '') AND ("Currency Code" <> '')) OR
//                           ((BestPurchPrice."Variant Code" = '') AND ("Variant Code" <> '')):
//                                 BestPurchPrice := PurchPrice;
//                             ((BestPurchPrice."Currency Code" = '') OR ("Currency Code" <> '')) AND
//                           ((BestPurchPrice."Variant Code" = '') OR ("Variant Code" <> '')):
//                                 IF (BestPurchPrice."Direct Unit Cost" = 0) OR
//                                    (CalcLineAmount(BestPurchPrice) > CalcLineAmount(PurchPrice))
//                                 THEN
//                                     BestPurchPrice := PurchPrice;
//                         END;
//                     END;
//                 UNTIL NEXT = 0;
//         END;

//         IF BestPurchPrice."Direct Unit Cost" = 0 THEN BEGIN
//             PriceInSKU := PriceInSKU AND (SKU."Last Direct Cost" <> 0);
//             IF PriceInSKU THEN
//                 BestPurchPrice."Direct Unit Cost" := SKU."Last Direct Cost"
//             ELSE
//                 BestPurchPrice."Direct Unit Cost" := Item."Last Direct Cost";

//             ConvertPriceToVAT(FALSE, Item."VAT Prod. Posting Group", '', BestPurchPrice."Direct Unit Cost");
//             ConvertPriceToUoM('', BestPurchPrice."Direct Unit Cost");
//             ConvertPriceLCYToFCY('', BestPurchPrice."Direct Unit Cost");
//         END;

//         PurchPrice := BestPurchPrice;
//     end;

//     local procedure CalcBestLineDisc(var PurchLineDisc: Record "Purchase Line Discount");
//     var
//         BestPurchLineDisc: Record "Purchase Line Discount";
//     begin
//         WITH PurchLineDisc DO
//             IF FIND('-') THEN
//                 REPEAT
//                     IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN
//                         CASE TRUE OF
//                             ((BestPurchLineDisc."Currency Code" = '') AND ("Currency Code" <> '')) OR
//                           ((BestPurchLineDisc."Variant Code" = '') AND ("Variant Code" <> '')):
//                                 BestPurchLineDisc := PurchLineDisc;
//                             ((BestPurchLineDisc."Currency Code" = '') OR ("Currency Code" <> '')) AND
//                           ((BestPurchLineDisc."Variant Code" = '') OR ("Variant Code" <> '')):
//                                 IF BestPurchLineDisc."Line Discount %" < "Line Discount %" THEN
//                                     BestPurchLineDisc := PurchLineDisc;
//                         END;
//                 UNTIL NEXT = 0;

//         PurchLineDisc := BestPurchLineDisc;
//     end;

//     procedure FindPurchPrice(var ToPurchPrice: Record "Purchase Price"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
//     var
//         FromPurchPrice: Record "Purchase Price";
//     begin
//         WITH FromPurchPrice DO BEGIN
//             SETRANGE("Item No.", ItemNo);
//             SETRANGE("Vendor No.", VendorNo);
//             SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
//             SETFILTER("Variant Code", '%1|%2', VariantCode, '');
//             IF NOT ShowAll THEN BEGIN
//                 SETRANGE("Starting Date", 0D, StartingDate);
//                 SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
//                 SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
//             END;

//             ToPurchPrice.RESET;
//             ToPurchPrice.DELETEALL;
//             IF FromPurchPrice.FIND('-') THEN
//                 REPEAT
//                     IF FromPurchPrice."Direct Unit Cost" <> 0 THEN BEGIN
//                         ToPurchPrice := FromPurchPrice;
//                         ToPurchPrice.INSERT;
//                     END;
//                 UNTIL FromPurchPrice.NEXT = 0;
//         END;
//     end;

//     procedure FindPurchLineDisc(var ToPurchLineDisc: Record "Purchase Line Discount"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
//     var
//         FromPurchLineDisc: Record "Purchase Line Discount";
//     begin
//         WITH FromPurchLineDisc DO BEGIN
//             SETRANGE("Item No.", ItemNo);
//             SETRANGE("Vendor No.", VendorNo);
//             SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
//             SETFILTER("Variant Code", '%1|%2', VariantCode, '');
//             IF NOT ShowAll THEN BEGIN
//                 SETRANGE("Starting Date", 0D, StartingDate);
//                 SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
//                 SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
//             END;

//             ToPurchLineDisc.RESET;
//             ToPurchLineDisc.DELETEALL;

//             IF FIND('-') THEN
//                 REPEAT
//                     IF FromPurchLineDisc."Line Discount %" <> 0 THEN BEGIN
//                         ToPurchLineDisc := FromPurchLineDisc;
//                         ToPurchLineDisc.INSERT;
//                     END;
//                 UNTIL FromPurchLineDisc.NEXT = 0;
//         END;
//     end;

//     local procedure SetCurrency(CurrencyCode2: Code[10]; CurrencyFactor2: Decimal; ExchRateDate2: Date);
//     begin
//         PricesInCurrency := CurrencyCode2 <> '';
//         IF PricesInCurrency THEN BEGIN
//             Currency.GET(CurrencyCode2);
//             Currency.TESTFIELD("Unit-Amount Rounding Precision");
//             CurrencyFactor := CurrencyFactor2;
//             ExchRateDate := ExchRateDate2;
//         END ELSE
//             GLSetup.GET;
//     end;

//     local procedure SetVAT(PriceInclVAT2: Boolean; VATPerCent2: Decimal; VATBusPostingGr2: Code[10]);
//     begin
//         PricesInclVAT := PriceInclVAT2;
//         VATPerCent := VATPerCent2;
//         VATBusPostingGr := VATBusPostingGr2;
//     end;

//     local procedure SetUoM(Qty2: Decimal; QtyPerUoM2: Decimal);
//     begin
//         Qty := Qty2;
//         QtyPerUOM := QtyPerUoM2;
//     end;

//     local procedure SetLineDisc(LineDiscPerCent2: Decimal);
//     begin
//         LineDiscPerCent := LineDiscPerCent2;
//     end;

//     local procedure IsInMinQty(UnitOfMeasureCode: Code[10]; MinQty: Decimal): Boolean;
//     begin
//         IF UnitOfMeasureCode = '' THEN
//             EXIT(MinQty <= QtyPerUOM * Qty);
//         EXIT(MinQty <= Qty);
//     end;

//     local procedure ConvertPriceToVAT(FromPriceInclVAT: Boolean; FromVATProdPostingGr: Code[10]; FromVATBusPostingGr: Code[10]; var UnitPrice: Decimal);
//     var
//         VATPostingSetup: Record "VAT Posting Setup";
//     begin
//         IF FromPriceInclVAT THEN BEGIN
//             IF NOT VATPostingSetup.GET(FromVATBusPostingGr, FromVATProdPostingGr) THEN
//                 VATPostingSetup.INIT;

//             IF PricesInclVAT THEN BEGIN
//                 IF VATBusPostingGr <> FromVATBusPostingGr THEN
//                     UnitPrice := UnitPrice * (100 + VATPerCent) / (100 + VATPostingSetup."VAT %");
//             END ELSE
//                 UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
//         END ELSE
//             IF PricesInclVAT THEN
//                 UnitPrice := UnitPrice * (1 + VATPerCent / 100);
//     end;

//     local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal);
//     begin
//         IF UnitOfMeasureCode = '' THEN
//             UnitPrice := UnitPrice * QtyPerUOM;
//     end;

//     local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal);
//     var
//         CurrExchRate: Record "Currency Exchange Rate";
//     begin
//         IF PricesInCurrency THEN BEGIN
//             IF CurrencyCode = '' THEN
//                 UnitPrice :=
//                   CurrExchRate.ExchangeAmtLCYToFCY(ExchRateDate, Currency.Code, UnitPrice, CurrencyFactor);
//             UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
//         END ELSE
//             UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
//     end;

//     local procedure CalcLineAmount(PurchPrice: Record "Purchase Price"): Decimal;
//     begin
//         WITH PurchPrice DO
//             EXIT("Direct Unit Cost" * (1 - LineDiscPerCent / 100));
//     end;

//     procedure PurchLinePriceExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
//     begin
//         WITH PurchLine DO
//             IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
//                 FindPurchPrice(
//                   TempPurchPrice, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
//                   PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
//                 EXIT(TempPurchPrice.FIND('-'));
//             END;
//         EXIT(FALSE);
//     end;

//     procedure PurchLineLineDiscExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
//     begin
//         WITH PurchLine DO
//             IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
//                 FindPurchLineDisc(
//                   TempPurchLineDisc, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
//                   PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
//                 EXIT(TempPurchLineDisc.FIND('-'));
//             END;
//         EXIT(FALSE);
//     end;

//     local procedure PurchHeaderExchDate(PurchHeader: Record "ADT Requisition Header"): Date;
//     begin
//         WITH PurchHeader DO BEGIN
//             IF ("Document Type" IN ["Document Type"::"Store Requisition", "Document Type"::"Purchase Requisition"]) AND
//                ("Posting Date" = 0D)
//             THEN
//                 EXIT(WORKDATE);
//             EXIT("Posting Date");
//         END;
//     end;

//     local procedure PurchHeaderStartDate(PurchHeader: Record "ADT Requisition Header"; var DateCaption: Text[30]): Date;
//     begin
//         WITH PurchHeader DO BEGIN
//             DateCaption := FIELDCAPTION("Order Date");
//             EXIT("Order Date");
//         END;
//     end;

//     procedure FindJobPlanningLinePrice(var JobPlanningLine: Record "Job Planning Line"; CalledByFieldNo: Integer);
//     var
//         JTHeader: Record Job;
//     begin
//         WITH JobPlanningLine DO BEGIN
//             SetCurrency("Currency Code", "Currency Factor", "Planning Date");
//             SetVAT(FALSE, 0, '');
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             TESTFIELD("Qty. per Unit of Measure");

//             CASE Type OF
//                 Type::Item:
//                     BEGIN
//                         Item.GET("No.");
//                         PriceInSKU := SKU.GET('', "No.", "Variant Code");
//                         JTHeader.GET("Job No.");

//                         FindPurchPrice(
//                           TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", '', "Planning Date", FALSE);
//                         PricesInCurrency := FALSE;
//                         GLSetup.GET;
//                         CalcBestDirectUnitCost(TempPurchPrice);
//                         SetCurrency("Currency Code", "Currency Factor", "Planning Date");

//                         IF FoundPurchPrice OR
//                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//                         THEN
//                             "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

//                     END;
//                 Type::Resource:
//                     BEGIN
//                         ResCost.INIT;
//                         ResCost.Code := "No.";
//                         ResCost."Work Type Code" := "Work Type Code";
//                         ResFindUnitCost.RUN(ResCost);

//                         ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
//                         "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
//                         VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
//                     END;
//             END;
//             VALIDATE("Direct Unit Cost (LCY)");
//         END;
//     end;

//     procedure FindJobJnlLinePrice(var JobJnlLine: Record "Job Journal Line"; CalledByFieldNo: Integer);
//     var
//         JTHeader: Record Job;
//     begin
//         WITH JobJnlLine DO BEGIN
//             SetCurrency("Currency Code", "Currency Factor", "Posting Date");
//             SetVAT(FALSE, 0, '');
//             SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//             TESTFIELD("Qty. per Unit of Measure");

//             CASE Type OF
//                 Type::Item:
//                     BEGIN
//                         Item.GET("No.");
//                         PriceInSKU := SKU.GET('', "No.", "Variant Code");
//                         JTHeader.GET("Job No.");

//                         FindPurchPrice(
//                           TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", "Country/Region Code", "Posting Date", FALSE);
//                         PricesInCurrency := FALSE;
//                         GLSetup.GET;
//                         CalcBestDirectUnitCost(TempPurchPrice);
//                         SetCurrency("Currency Code", "Currency Factor", "Posting Date");

//                         IF FoundPurchPrice OR
//                            NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
//                                 (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
//                         THEN
//                             "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

//                     END;
//                 Type::Resource:
//                     BEGIN
//                         ResCost.INIT;
//                         ResCost.Code := "No.";
//                         ResCost."Work Type Code" := "Work Type Code";
//                         ResFindUnitCost.RUN(ResCost);

//                         ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
//                         "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
//                         VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
//                     END;
//             END;
//             VALIDATE("Direct Unit Cost (LCY)");
//         END;
//     end;

//     procedure NoOfPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
//     begin
//         IF PurchLinePriceExists(PurchHeader, PurchLine, ShowAll) THEN
//             EXIT(TempPurchPrice.COUNT);
//     end;

//     procedure NoOfPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
//     begin
//         IF PurchLineLineDiscExists(PurchHeader, PurchLine, ShowAll) THEN
//             EXIT(TempPurchLineDisc.COUNT);
//     end;

//     procedure GetPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
//     begin
//         PurchLinePriceExists(PurchHeader, PurchLine, TRUE);

//         WITH PurchLine DO
//             IF PAGE.RUNMODAL(PAGE::"Get Purchase Price", TempPurchPrice) = ACTION::LookupOK THEN BEGIN

//                 SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
//                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
//                 SetCurrency(
//                   PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));

//                 IF NOT IsInMinQty(TempPurchPrice."Unit of Measure Code", TempPurchPrice."Minimum Quantity") THEN
//                     ERROR(
//                       Text020,
//                       FIELDCAPTION(Quantity),
//                       TempPurchPrice.FIELDCAPTION("Minimum Quantity"),
//                       TempPurchPrice.TABLECAPTION);
//                 IF NOT (TempPurchPrice."Currency Code" IN ["Currency Code", '']) THEN
//                     ERROR(
//                       Text040,
//                       FIELDCAPTION("Currency Code"),
//                       TABLECAPTION,
//                       TempPurchPrice.TABLECAPTION);
//                 IF NOT (TempPurchPrice."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
//                     ERROR(
//                       Text040,
//                       FIELDCAPTION("Unit of Measure Code"),
//                       TABLECAPTION,
//                       TempPurchPrice.TABLECAPTION);
//                 IF TempPurchPrice."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
//                     ERROR(
//                       Text020,
//                       DateCaption,
//                       TempPurchPrice.FIELDCAPTION("Starting Date"),
//                       TempPurchPrice.TABLECAPTION);

//                 ConvertPriceToVAT(
//                   PurchHeader."Prices Including VAT", Item."VAT Prod. Posting Group",
//                  "VAT Bus. Posting Group", TempPurchPrice."Direct Unit Cost");
//                 ConvertPriceToUoM("Unit of Measure Code", TempPurchPrice."Direct Unit Cost");
//                 ConvertPriceLCYToFCY(TempPurchPrice."Currency Code", TempPurchPrice."Direct Unit Cost");

//                 VALIDATE("Direct Unit Cost", TempPurchPrice."Direct Unit Cost");
//             END;
//     end;

//     procedure GetPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
//     begin
//         PurchLineLineDiscExists(PurchHeader, PurchLine, TRUE);

//         WITH PurchLine DO
//             IF PAGE.RUNMODAL(PAGE::"Get Purchase Line Disc.", TempPurchLineDisc) = ACTION::LookupOK THEN BEGIN
//                 SetCurrency(PurchHeader."Currency Code", 0, 0D);
//                 SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

//                 IF NOT IsInMinQty(TempPurchLineDisc."Unit of Measure Code", TempPurchLineDisc."Minimum Quantity")
//                 THEN
//                     ERROR(
//                       Text020, FIELDCAPTION(Quantity),
//                       TempPurchLineDisc.FIELDCAPTION("Minimum Quantity"),
//                       TempPurchLineDisc.TABLECAPTION);
//                 IF NOT (TempPurchLineDisc."Currency Code" IN ["Currency Code", '']) THEN
//                     ERROR(
//                       Text040,
//                       FIELDCAPTION("Currency Code"),
//                       TABLECAPTION,
//                       TempPurchLineDisc.TABLECAPTION);
//                 IF NOT (TempPurchLineDisc."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
//                     ERROR(
//                       Text040,
//                       FIELDCAPTION("Unit of Measure Code"),
//                       TABLECAPTION,
//                       TempPurchLineDisc.TABLECAPTION);
//                 IF TempPurchLineDisc."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
//                     ERROR(
//                       Text020,
//                       DateCaption,
//                       TempPurchLineDisc.FIELDCAPTION("Starting Date"),
//                       TempPurchLineDisc.TABLECAPTION);

//                 VALIDATE("Line Discount %", TempPurchLineDisc."Line Discount %");
//             END;
//     end;

//     //========Approval Workflow Management - PRQ========

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
//     local procedure OnAfterGetPageIDPRQ(RecordRef: RecordRef; var PageID: Integer)
//     begin
//         if PageID = 0 then
//             PageID := GetConditionalCardPageIDPRQ(RecordRef);
//     end;

//     local procedure GetConditionalCardPageIDPRQ(RecordRef: RecordRef): Integer
//     var
//         RequisitionHeader: Record "ADT Requisition Header";
//     begin
//         RecordRef.SetTable(RequisitionHeader);
//         case RequisitionHeader."Document Type" of
//             RequisitionHeader."Document Type"::"Purchase Requisition":
//                 if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
//                     exit(PAGE::"Spare Part Requisition");
//             RequisitionHeader."Document Type"::"Store Requisition":
//                 if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
//                     exit(PAGE::"Fuel Requisition");
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
//     local procedure OnOpenDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
//     var
//         Claim: Record "ADT Requisition Header";
//     begin
//         case RecRef.Number of
//             Database::"ADT Requisition Header":
//                 begin
//                     RecRef.SetTable(Claim);
//                     Claim.Status := Claim.Status::Open;
//                     Claim.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
//     local procedure OnReleaseDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
//     var
//         Claim: Record "ADT Requisition Header";
//     begin
//         case RecRef.Number of
//             Database::"ADT Requisition Header":
//                 begin
//                     RecRef.SetTable(Claim);
//                     Claim.Status := Claim.Status::Released;
//                     Claim.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
//     local procedure OnSetStatusToPendingApprovalPRQ(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         claim: Record "ADT Requisition Header";
//     begin
//         case RecRef.Number of
//             Database::"ADT Requisition Header":
//                 begin
//                     RecRef.SetTable(claim);
//                     claim.Status := claim.Status::"Pending approval";
//                     claim.Modify();
//                     IsHandled := true;
//                 end;
//         end;
//     end;

    

//     procedure CheckBudgetPurchasePRQ(var RequisitionHeader: Record "ADT Requisition Header");
//     var
//         RequisitionLine: Record "ADT Requisition Line";
//     begin
//         if RequisitionHeader."Document Type" = RequisitionHeader."Document Type"::"Purchase Requisition" then begin
//             RequisitionHeader.TESTFIELD("Shortcut Dimension 1 Code");
//             RequisitionLine.RESET;
//             IF RequisitionHeader.Status = RequisitionHeader.Status::"Pending Approval" THEN BEGIN
//                 RequisitionLine.SETRANGE("Document Type", RequisitionHeader."Document Type");
//                 RequisitionLine.SETRANGE("Document No.", RequisitionHeader."No.");
//                 IF RequisitionLine.FIND('-') THEN
//                     REPEAT
//                         IF RequisitionLine.Type = RequisitionLine.Type::"G/L Account" THEN BEGIN
//                             if RequisitionLine."G/L Account Type" = RequisitionLine."G/L Account Type"::"Income Statement" then begin
//                                 IF RequisitionLine."Budget Comment" = 'Out of Budget' THEN BEGIN
//                                     ERROR('Purchase Requisition Line %1 is Out of Budget and must be escalated to CFO/CEO!', RequisitionLine."Line No.");
//                                 END;
//                             end;
//                         END;
//                     UNTIL RequisitionLine.NEXT = 0;
//             END;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowResponsePredecessorsToLibraryPRQ(ResponseFunctionName: Code[128])
//     var
//         WorkflowResponseHandling: Codeunit 1521;
//         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
//     begin
//         case ResponseFunctionName of
//             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
//             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
//             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
//             WorkflowResponseHandling.OpenDocumentCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
//         end;
//     end;

//     procedure CheckClaimApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
//     begin
//         if not IsClaimDocApprovalsWorkflowEnablePRQ(Claim) then
//             Error(NoWorkflowEnabledErrPRQ);
//         exit(true);
//     end;

//     procedure IsClaimDocApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
//     begin
//         if Claim.Status <> Claim.Status::Open then
//             exit(false);
//         exit(WorkflowManagementPRQ.CanExecuteWorkflow(Claim, WorkflowEventHandlingCustPRQ.RunWorkflowOnSendClaimForApprovalCodePRQ));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     local procedure OnPopulateApprovalEntryArgumentPRQ(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         Claim: Record "ADT Requisition Header";
//     begin
//         case RecRef.Number of
//             Database::"ADT Requisition Header":
//                 begin
//                     RecRef.SetTable(Claim);
//                     ApprovalEntryArgument."Document No." := Claim."No.";
//                     ApprovalEntryArgument."Requisition Type" := Claim."Document Type"::"Store Requisition";
//                 end;
//         end;
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
//     begin
//     end;

//     procedure ReOpenLoanAdvancePRQ(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         LoanAdvance: Record "ADT Requisition Header";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenLoanAdvancePRQ(Variant);
//                 end;
//             DATABASE::Job:
//                 begin
//                     RecRef.SetTable(LoanAdvance);
//                     LoanAdvance.Validate(Status, LoanAdvance.Status::Open);
//                     LoanAdvance.Modify();
//                     Variant := LoanAdvance;
//                 end;
//         end;
//     end;

//     procedure modifyApprovalEntryPRQ(PurchaseReqHeader: Record "ADT Requisition Header")
//     var
//         NflRequisitionLine: Record "ADT Requisition Line";
//         AmountLcy: Decimal;
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         AmountLcy := 0;
//         PurchaseReqHeader.CalcFields("Total Cost");
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseReqHeader."No.");
//         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//         if ApprovalEntry.FindFirst() then
//             repeat
//                 if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Purchase Requisition" then begin
//                     ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
//                     ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
//                     ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
//                     ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
//                     ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
//                     ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
//                     ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
//                     ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
//                     ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
//                     ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
//                 end else
//                     if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Store Requisition" then begin
//                         ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
//                         ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
//                         ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
//                         ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
//                         ApprovalEntry.Amount := PurchaseReqHeader."Total Cost";
//                         ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
//                         ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
//                         ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
//                         ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
//                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
//                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
//                     end;
//                 ApprovalEntry.Modify();
//             until ApprovalEntry.Next() = 0;
//     end;

//     procedure UpdateApprovalEntryInfoPRQ()
//     var
//         PurchReq: Record "ADT Requisition Header";
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         PurchReq.Reset();
//         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Purchase Requisition");
//         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
//         if PurchReq.FindFirst() then
//             repeat
//                 PurchReq.CalcFields("Total Cost");
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := PurchReq."Document Type";
//                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
//                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
//                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
//                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
//                         ApprovalEntry.Description := PurchReq."Posting Description";
//                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
//                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
//                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until PurchReq.Next() = 0;

//         PurchReq.Reset();
//         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
//         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
//         if PurchReq.FindFirst() then
//             repeat
//                 PurchReq.CalcFields("Total Cost");
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := PurchReq."Document Type";
//                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
//                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
//                         ApprovalEntry.Amount := PurchReq."Total Cost";
//                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
//                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
//                         ApprovalEntry.Description := PurchReq."Posting Description";
//                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
//                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
//                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until PurchReq.Next() = 0;
//         Message('Done Now');
//     end;

//     procedure UpdateApprovalEntryInfoSTRQ()
//     var
//         PurchReq: Record "ADT Requisition Header";
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         PurchReq.Reset();
//         PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
//         PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
//         if PurchReq.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := PurchReq."Document Type";
//                         ApprovalEntry."Prepared By" := PurchReq."Prepared by";
//                         ApprovalEntry."Currency Code" := PurchReq."Currency Code";
//                         ApprovalEntry."Payee No." := PurchReq."Request-By No.";
//                         ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
//                         ApprovalEntry.Description := PurchReq."Posting Description";
//                         ApprovalEntry."Posting Date" := PurchReq."Posting Date";
//                         ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
//                         ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until PurchReq.Next() = 0;
//         Message('Done Now');
//     end;

//     procedure OpenApprovalEntriesPRQ(Rec: Record "ADT Requisition Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         SequenceNo: Integer;
//     begin
//         SequenceNo := 0;
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
//         if ApprovalEntries.FindFirst() then begin
//             SequenceNo := ApprovalEntries."Sequence No." + 1;
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
//             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
//             if ApprovalEntries1.FindFirst() then begin
//                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
//                 ApprovalEntries1.Modify();
//             end;
//         end;
//     end;

//     procedure RejectApprovalRequestPRQ(Rec: Record "ADT Requisition Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         NvText: Label 'The approval Request has been rejected';
//     begin
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
//         if ApprovalEntries.FindFirst() then begin
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
//             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
//             if ApprovalEntries1.FindFirst() then begin
//                 repeat
//                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
//                     ApprovalEntries1.Modify();
//                 until ApprovalEntries1.Next() = 0;
//             end;
//             OpenDocumentPRQ(Rec);
//             Message(NvText);
//         end;
//     end;

//     procedure OpenDocumentPRQ(Rec: Record "ADT Requisition Header")
//     var
//         NFLRequisitionHeader: Record "ADT Requisition Header";
//     begin
//         NFLRequisitionHeader.Reset();
//         NFLRequisitionHeader.SetRange(NFLRequisitionHeader."No.", Rec."No.");
//         NFLRequisitionHeader.SetRange(NFLRequisitionHeader.Status, NFLRequisitionHeader.Status::"Pending Approval");
//         if NFLRequisitionHeader.FindFirst() then begin
//             NFLRequisitionHeader.Status := NFLRequisitionHeader.Status::Open;
//             NFLRequisitionHeader.Modify();
//         end;
//     end;

//     procedure DelegatePurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetup: Record "User Setup";
//         Txt00003: Label 'Are you sure you want to delegate to:';
//         MessageToSend: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             UserSetup.Reset();
//             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
//             if UserSetup.FindFirst() then begin
//                 if UserSetup.Substitute <> '' then begin
//                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
//                     if Confirm(MessageToSend, true) then begin
//                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
//                         ApprovalEntry."Last Modified By User ID" := UserId;
//                         ApprovalEntry.Modify();
//                         Message('Requisition has been Delegated to %1 Successfully', UserSetup.Substitute);
//                     end;
//                 end else begin
//                     Error('Substitute can not be empty. Contact your Systems Administrator');
//                 end;
//             end else begin
//                 Error('You are not setup please consult your System Administrator');
//             end;
//         end else begin
//             Error('You are not allowed to Delegate please contact your system Administrator');
//         end;
//     end;

//     procedure escalateDocPRQ(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; NFLRequisitionHeader: Record "ADT Requisition Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         Txt0010: Label 'Are you sure you want to escalate to';
//         SendMessage: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
//         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
//         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             SendMessage := Txt0010 + ' ' + EscalateTo;
//             if Confirm(SendMessage, true) then begin
//                 ApprovalEntry."Approver ID" := EscalateTo;
//                 ApprovalEntry."Escalated By" := userIDEsc;
//                 ApprovalEntry."Escalated On" := Today();
//                 ApprovalEntry.Modify();
//                 Message('Document has been Escalated to: %1', EscalateTo);
//             end else
//                 Message('The Document has not been escalate');
//         end;
//     end;

//     procedure CancelPurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         PurchRequisitionHeader: Record "ADT Requisition Header";
//     begin
//         PurchRequisitionHeader.Reset();
//         PurchRequisitionHeader.SetRange(PurchRequisitionHeader."No.", RequisitionHeader."No.");
//         PurchRequisitionHeader.SetRange(PurchRequisitionHeader.Status, PurchRequisitionHeader.Status::"Pending Approval");
//         if PurchRequisitionHeader.FindFirst() then begin
//             ApprovalEntry.Reset();
//             ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
//             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
//             if ApprovalEntry.FindFirst() then begin
//                 repeat
//                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                     ApprovalEntry."Last Modified By User ID" := UserId;
//                     ApprovalEntry.Modify();
//                 until ApprovalEntry.Next() = 0;
//             end;
//             PurchRequisitionHeader.Status := PurchRequisitionHeader.Status::Open;
//             PurchRequisitionHeader.Modify();
//         end;
//         Message('The Request has been Cancelled');
//     end;

//     procedure ReopenApprovalEntriesPRQ(RequisitionHeader: Record "ADT Requisition Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetUp: Record "User Setup";
//         VoucherAdmin: Boolean;
//     begin
//         if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
//             exit;

//         VoucherAdmin := false;
//         UserSetUp.Reset();
//         UserSetUp.SetRange(UserSetUp."User ID", UserId);
//         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
//         if UserSetUp.FindFirst() then
//             VoucherAdmin := true;

//         if VoucherAdmin then begin
//             if RequisitionHeader.Status = RequisitionHeader.Status::Open then begin
//                 ApprovalEntry.Reset();
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
//                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             end;
//         end;
//     end;

//     procedure EscalateGeneralRequisition(var Requisition: Record "ADT Requisition Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         UserSetup: Record "User Setup";
//         Text001: Text;
//     begin
//         Requisition.CalcFields("Current Approver");
//         UserSetup.Reset();
//         UserSetup.SetRange("User ID", Requisition."Current Approver");
//         UserSetup.SetRange("SBU Head", true);
//         if UserSetup.FindFirst() then begin
//             UserSetup.TestField("Escalate to");
//             Text001 := 'The Requisition will be escalated to ' + UserSetup."Escalate to" + ' do you want to continue?';
//             if Confirm(Text001, true) then begin
//                 ApprovalEntries.Reset();
//                 ApprovalEntries.SetRange("Approver ID", Requisition."Current Approver");
//                 ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);
//                 ApprovalEntries.SetRange("Document No.", Requisition."No.");
//                 if ApprovalEntries.FindFirst() then begin
//                     ApprovalEntries.Validate("Approver ID", UserSetup."Escalate to");
//                     ApprovalEntries.Validate("Escalated By", UserId);
//                     ApprovalEntries.Validate("Escalated On", Today());
//                     ApprovalEntries.Modify();
//                     Message('The Requisition has been escalated to %1', UserSetup."Escalate to");
//                 end;
//             end;
//         end else begin
//             Error('No User Setup record found for user: %1', Requisition."Current Approver");
//         end;
//     end;

//     //===============Approval workflow mgt for Maintenance Request================

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
//     local procedure OnAfterGetPageIDMR(RecordRef: RecordRef; var PageID: Integer)
//     begin
//         if PageID = 0 then
//             PageID := GetConditionalCardPageIDMR(RecordRef);
//     end;

//     local procedure GetConditionalCardPageIDMR(RecordRef: RecordRef): Integer
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         RecordRef.SetTable(MaintenanceHeader);
//         case MaintenanceHeader."Document Type" of
//             MaintenanceHeader."Document Type"::"Maintenance Request":
//                 exit(PAGE::"Maintenance Request");
//             MaintenanceHeader."Document Type"::"Job Card":
//                 exit(PAGE::"Maintenance Job Card");
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
//     local procedure OnOpenDocumentMR(RecRef: RecordRef; var Handled: Boolean)
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         case RecRef.Number of
//             Database::"Maintenance Header":
//                 begin
//                     RecRef.SetTable(MaintenanceHeader);
//                     MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
//                     MaintenanceHeader.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
//     local procedure OnReleaseDocumentMR(RecRef: RecordRef; var Handled: Boolean)
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         case RecRef.Number of
//             Database::"Maintenance Header":
//                 begin
//                     RecRef.SetTable(MaintenanceHeader);
//                     MaintenanceHeader.Status := MaintenanceHeader.Status::Released;
//                     MaintenanceHeader.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
//     local procedure OnSetStatusToPendingApprovalMR(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         case RecRef.Number of
//             Database::"Maintenance Header":
//                 begin
//                     RecRef.SetTable(MaintenanceHeader);
//                     MaintenanceHeader.Status := MaintenanceHeader.Status::"Pending approval";
//                     MaintenanceHeader.Modify();
//                     IsHandled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowResponsePredecessorsToLibraryMR(ResponseFunctionName: Code[128])
//     var
//         WorkflowResponseHandling: Codeunit 1521;
//         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
//     begin
//         case ResponseFunctionName of
//             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
//             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
//             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
//             WorkflowResponseHandling.OpenDocumentCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
//         end;
//     end;

//     procedure CheckClaimApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
//     begin
//         if not IsClaimDocApprovalsWorkflowEnableMR(MaintenanceHeader) then
//             Error(NoWorkflowEnabledErrMR);
//         exit(true);
//     end;

//     procedure IsClaimDocApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
//     begin
//         if MaintenanceHeader.Status <> MaintenanceHeader.Status::Open then
//             exit(false);
//         exit(WorkflowManagementMR.CanExecuteWorkflow(MaintenanceHeader, WorkflowEventHandlingCustMR.RunWorkflowOnSendClaimForApprovalCodeMR));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     local procedure OnPopulateApprovalEntryArgumentMR(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         case RecRef.Number of
//             Database::"Maintenance Header":
//                 begin
//                     RecRef.SetTable(MaintenanceHeader);
//                     ApprovalEntryArgument."Document No." := MaintenanceHeader."No.";
//                 end;
//         end;
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
//     begin
//     end;

//     procedure ReOpenLoanAdvanceMR(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenLoanAdvanceMR(Variant);
//                 end;
//             DATABASE::"Maintenance Header":
//                 begin
//                     RecRef.SetTable(MaintenanceHeader);
//                     MaintenanceHeader.Validate(Status, MaintenanceHeader.Status::Open);
//                     MaintenanceHeader.Modify();
//                     Variant := MaintenanceHeader;
//                 end;
//         end;
//     end;

//     procedure modifyApprovalEntryMR(MaintenanceHeader: Record "Maintenance Header")
//     var
//         AmountLcy: Decimal;
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         AmountLcy := 0;
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
//         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//         if ApprovalEntry.FindFirst() then
//             repeat
//                 if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Maintenance Request" then begin
//                     ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
//                     ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
//                     ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
//                     ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
//                     ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
//                 end else if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Job Card" then begin
//                     ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
//                     ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
//                     ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
//                     ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
//                     ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
//                 end;
//                 ApprovalEntry.Modify();
//             until ApprovalEntry.Next() = 0;
//     end;

//     procedure UpdateApprovalEntryInfoMR()
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         MaintenanceHeader.Reset();
//         MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Maintenance Request");
//         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
//         if MaintenanceHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
//                         ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
//                         ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
//                         ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
//                         ApprovalEntry.Amount := 0;
//                         ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
//                         ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until MaintenanceHeader.Next() = 0;

//         MaintenanceHeader.Reset();
//         MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Job Card");
//         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
//         if MaintenanceHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
//                         ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
//                         ApprovalEntry.Amount := 0;
//                         ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
//                         ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
//                         ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
//                         ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until MaintenanceHeader.Next() = 0;
//     end;

//     procedure OpenApprovalEntriesMR(Rec: Record "Maintenance Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         SequenceNo: Integer;
//     begin
//         SequenceNo := 0;
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
//         if ApprovalEntries.FindFirst() then begin
//             SequenceNo := ApprovalEntries."Sequence No." + 1;
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
//             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
//             if ApprovalEntries1.FindFirst() then begin
//                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
//                 ApprovalEntries1.Modify();
//             end;
//         end;
//     end;

//     procedure RejectApprovalRequestMR(Rec: Record "Maintenance Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         NvText: Label 'The approval Request has been rejected';
//     begin
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
//         if ApprovalEntries.FindFirst() then begin
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
//             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
//             if ApprovalEntries1.FindFirst() then begin
//                 repeat
//                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
//                     ApprovalEntries1.Modify();
//                 until ApprovalEntries1.Next() = 0;
//             end;
//             OpenDocumentMR(Rec);
//             Message(NvText);
//         end;
//     end;

//     procedure OpenDocumentMR(Rec: Record "Maintenance Header")
//     var
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         MaintenanceHeader.Reset();
//         MaintenanceHeader.SetRange(MaintenanceHeader."No.", Rec."No.");
//         MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
//         if MaintenanceHeader.FindFirst() then begin
//             MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
//             MaintenanceHeader.Modify();
//         end;
//     end;

//     procedure DelegatePurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetup: Record "User Setup";
//         Txt00003: Label 'Are you sure you want to delegate to:';
//         MessageToSend: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             UserSetup.Reset();
//             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
//             if UserSetup.FindFirst() then begin
//                 if UserSetup.Substitute <> '' then begin
//                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
//                     if Confirm(MessageToSend, true) then begin
//                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
//                         ApprovalEntry."Last Modified By User ID" := UserId;
//                         ApprovalEntry.Modify();
//                         Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
//                     end;
//                 end else begin
//                     Error('Substitute can not be empty. Contact your Systems Administrator');
//                 end;
//             end else begin
//                 Error('You are not setup please consult your System Administrator');
//             end;
//         end else begin
//             Error('You are not allowed to Delegate please contact your system Administrator');
//         end;
//     end;

//     procedure escalateDocMR(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; MaintenanceHeader: Record "Maintenance Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         Txt0010: Label 'Are you sure you want to escalate to';
//         SendMessage: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
//         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
//         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             SendMessage := Txt0010 + ' ' + EscalateTo;
//             if Confirm(SendMessage, true) then begin
//                 ApprovalEntry."Approver ID" := EscalateTo;
//                 ApprovalEntry."Escalated By" := userIDEsc;
//                 ApprovalEntry."Escalated On" := Today();
//                 ApprovalEntry.Modify();
//                 Message('Document has been Escalated to: %1', EscalateTo);
//             end else
//                 Message('The Document has not been escalate');
//         end;
//     end;

//     procedure CancelPurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         RequisitionHeader: Record "Maintenance Header";
//     begin
//         RequisitionHeader.Reset();
//         RequisitionHeader.SetRange(RequisitionHeader."No.", MaintenanceHeader."No.");
//         RequisitionHeader.SetRange(RequisitionHeader.Status, RequisitionHeader.Status::"Pending Approval");
//         if RequisitionHeader.FindFirst() then begin
//             ApprovalEntry.Reset();
//             ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
//             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
//             if ApprovalEntry.FindFirst() then begin
//                 repeat
//                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                     ApprovalEntry."Last Modified By User ID" := UserId;
//                     ApprovalEntry.Modify();
//                 until ApprovalEntry.Next() = 0;
//             end;
//             RequisitionHeader.Status := RequisitionHeader.Status::Open;
//             RequisitionHeader.Modify();
//         end;
//         Message('The Request has been Cancelled');
//     end;

//     procedure ReopenApprovalEntriesMR(RequisitionHeader: Record "Maintenance Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetUp: Record "User Setup";
//         VoucherAdmin: Boolean;
//     begin
//         if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
//             exit;

//         VoucherAdmin := false;
//         UserSetUp.Reset();
//         UserSetUp.SetRange(UserSetUp."User ID", UserId);
//         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
//         if UserSetUp.FindFirst() then
//             VoucherAdmin := true;

//         if VoucherAdmin then begin
//             if RequisitionHeader.Status = RequisitionHeader.Status::Open then begin
//                 ApprovalEntry.Reset();
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
//                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             end;
//         end;
//     end;

//     //===============Approval workflow mgt for Form Request================

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
//     local procedure OnAfterGetPageIDFM(RecordRef: RecordRef; var PageID: Integer)
//     begin
//         if PageID = 0 then
//             PageID := GetConditionalCardPageIDFM(RecordRef);
//     end;

//     local procedure GetConditionalCardPageIDFM(RecordRef: RecordRef): Integer
//     var
//         FormHeader: Record "Form Header";
//         RequisitionHeader: Record "ADT Requisition Header";
//         MaintenanceHeader: Record "Maintenance Header";
//     begin
//         if RecordRef.Number = Database::"Form Header" then begin
//             RecordRef.SetTable(FormHeader);
//             case FormHeader."Document Type" of
//                 FormHeader."Document Type"::"Equipment Hand Over":
//                     exit(PAGE::"Equipment HandOver Form");
//                 FormHeader."Document Type"::"External Hire":
//                     exit(Page::"External Hire Request");
//                 FormHeader."Document Type"::"Journey Management Plan":
//                     exit(Page::"Journey Management Plan");
//             end;
//         end;
//         if RecordRef.Number = Database::"ADT Requisition Header" then begin
//             RecordRef.SetTable(RequisitionHeader);
//             case RequisitionHeader."Document Type" of
//                 RequisitionHeader."Document Type"::"Purchase Requisition":
//                     if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
//                         exit(PAGE::"Spare Part Requisition");
//                 RequisitionHeader."Document Type"::"Store Requisition":
//                     if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
//                         exit(PAGE::"Fuel Requisition");
//             end;
//         end;
//         if RecordRef.Number = Database::"Maintenance Header" then begin
//             RecordRef.SetTable(MaintenanceHeader);
//             case MaintenanceHeader."Document Type" of
//                 MaintenanceHeader."Document Type"::"Maintenance Request":
//                     exit(PAGE::"Maintenance Request");
//                 MaintenanceHeader."Document Type"::"Job Card":
//                     exit(PAGE::"Maintenance Job Card");
//             end;
//         end
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
//     local procedure OnOpenDocumentFM(RecRef: RecordRef; var Handled: Boolean)
//     var
//         FormHeader: Record "Form Header";
//     begin
//         case RecRef.Number of
//             Database::"Form Header":
//                 begin
//                     RecRef.SetTable(FormHeader);
//                     FormHeader.Status := FormHeader.Status::Open;
//                     FormHeader.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
//     local procedure OnReleaseDocumentFM(RecRef: RecordRef; var Handled: Boolean)
//     var
//         FormHeader: Record "Form Header";
//     begin
//         case RecRef.Number of
//             Database::"Form Header":
//                 begin
//                     RecRef.SetTable(FormHeader);
//                     FormHeader.Status := FormHeader.Status::Released;
//                     FormHeader.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
//     local procedure OnSetStatusToPendingApprovalFM(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         FormHeader: Record "Form Header";
//     begin
//         case RecRef.Number of
//             Database::"Form Header":
//                 begin
//                     RecRef.SetTable(FormHeader);
//                     FormHeader.Status := FormHeader.Status::"Pending approval";
//                     FormHeader.Modify();
//                     IsHandled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowResponsePredecessorsToLibraryFM(ResponseFunctionName: Code[128])
//     var
//         WorkflowResponseHandling: Codeunit 1521;
//         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
//     begin
//         case ResponseFunctionName of
//             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
//             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
//             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
//             WorkflowResponseHandling.OpenDocumentCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
//         end;
//     end;

//     procedure CheckClaimApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
//     begin
//         if not IsClaimDocApprovalsWorkflowEnableFM(FormHeader) then
//             Error(NoWorkflowEnabledErrFM);
//         exit(true);
//     end;

//     procedure IsClaimDocApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
//     begin
//         if FormHeader.Status <> FormHeader.Status::Open then
//             exit(false);
//         exit(WorkflowManagementFM.CanExecuteWorkflow(FormHeader, WorkflowEventHandlingCustFM.RunWorkflowOnSendClaimForApprovalCodeFM));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     local procedure OnPopulateApprovalEntryArgumentFM(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         FormHeader: Record "Form Header";
//     begin
//         case RecRef.Number of
//             Database::"Form Header":
//                 begin
//                     RecRef.SetTable(FormHeader);
//                     ApprovalEntryArgument."Document No." := FormHeader."No.";
//                 end;
//         end;
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendClaimForApprovalFM(var FormHeader: Record "Form Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelClaimForApprovalFM(var FormHeader: Record "Form Header")
//     begin
//     end;

//     procedure ReOpenLoanAdvanceFM(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         FormHeader: Record "Form Header";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenLoanAdvanceFM(Variant);
//                 end;
//             DATABASE::"Form Header":
//                 begin
//                     RecRef.SetTable(FormHeader);
//                     FormHeader.Validate(Status, FormHeader.Status::Open);
//                     FormHeader.Modify();
//                     Variant := FormHeader;
//                 end;
//         end;
//     end;

//     procedure modifyApprovalEntryFM(FormHeader: Record "Form Header")
//     var
//         AmountLcy: Decimal;
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         AmountLcy := 0;
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//         if ApprovalEntry.FindFirst() then
//             repeat
//                 if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Hand Over" then begin
//                     ApprovalEntry."Document Type" := FormHeader."Document Type";
//                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Posting Date" := FormHeader.Date;
//                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Inspection" then begin
//                     ApprovalEntry."Document Type" := FormHeader."Document Type";
//                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Posting Date" := FormHeader.Date;
//                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"External Hire" then begin
//                     ApprovalEntry."Document Type" := FormHeader."Document Type";
//                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Posting Date" := FormHeader.Date;
//                 end else if FormHeader."Document Type" = FormHeader."Document Type"::"Journey Management Plan" then begin
//                     ApprovalEntry."Document Type" := FormHeader."Document Type";
//                     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                     ApprovalEntry.Amount := 0;
//                     ApprovalEntry."Posting Date" := FormHeader.Date;
//                 end;
//                 ApprovalEntry.Modify();
//             until ApprovalEntry.Next() = 0;
//     end;

//     procedure UpdateApprovalEntryInfoFM()
//     var
//         FormHeader: Record "Form Header";
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Hand Over");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := FormHeader."Document Type";
//                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                         ApprovalEntry."Posting Date" := FormHeader.Date;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until FormHeader.Next() = 0;

//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Inspection");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := FormHeader."Document Type";
//                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                         ApprovalEntry.Amount := 0;
//                         ApprovalEntry."Posting Date" := FormHeader.Date;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until FormHeader.Next() = 0;

//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"External Hire");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := FormHeader."Document Type";
//                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                         ApprovalEntry.Amount := 0;
//                         ApprovalEntry."Posting Date" := FormHeader.Date;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until FormHeader.Next() = 0;

//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Journey Management Plan");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then
//             repeat
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//                 ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry."Document Type" := FormHeader."Document Type";
//                         ApprovalEntry."Prepared By" := FormHeader."Prepared by";
//                         ApprovalEntry.Amount := 0;
//                         ApprovalEntry."Posting Date" := FormHeader.Date;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             until FormHeader.Next() = 0;
//     end;

//     procedure OpenApprovalEntriesFM(Rec: Record "Form Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         SequenceNo: Integer;
//     begin
//         SequenceNo := 0;
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
//         if ApprovalEntries.FindFirst() then begin
//             SequenceNo := ApprovalEntries."Sequence No." + 1;
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
//             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
//             if ApprovalEntries1.FindFirst() then begin
//                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
//                 ApprovalEntries1.Modify();
//             end;
//         end;
//     end;

//     procedure RejectApprovalRequestFM(Rec: Record "Form Header")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         NvText: Label 'The approval Request has been rejected';
//     begin
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
//         if ApprovalEntries.FindFirst() then begin
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
//             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
//             if ApprovalEntries1.FindFirst() then begin
//                 repeat
//                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
//                     ApprovalEntries1.Modify();
//                 until ApprovalEntries1.Next() = 0;
//             end;
//             OpenDocumentFM(Rec);
//             Message(NvText);
//         end;
//     end;

//     procedure OpenDocumentFM(Rec: Record "Form Header")
//     var
//         FormHeader: Record "Form Header";
//     begin
//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."No.", Rec."No.");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then begin
//             FormHeader.Status := FormHeader.Status::Open;
//             FormHeader.Modify();
//         end;
//     end;

//     procedure DelegatePurchaseApprovalRequestFM(FormHeader: Record "Form Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetup: Record "User Setup";
//         Txt00003: Label 'Are you sure you want to delegate to:';
//         MessageToSend: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             UserSetup.Reset();
//             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
//             if UserSetup.FindFirst() then begin
//                 if UserSetup.Substitute <> '' then begin
//                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
//                     if Confirm(MessageToSend, true) then begin
//                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
//                         ApprovalEntry."Last Modified By User ID" := UserId;
//                         ApprovalEntry.Modify();
//                         Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
//                     end;
//                 end else begin
//                     Error('Substitute can not be empty. Contact your Systems Administrator');
//                 end;
//             end else begin
//                 Error('You are not setup please consult your System Administrator');
//             end;
//         end else begin
//             Error('You are not allowed to Delegate please contact your system Administrator');
//         end;
//     end;

//     procedure escalateDocFM(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; FormHeader: Record "Form Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         Txt0010: Label 'Are you sure you want to escalate to';
//         SendMessage: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
//         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
//         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             SendMessage := Txt0010 + ' ' + EscalateTo;
//             if Confirm(SendMessage, true) then begin
//                 ApprovalEntry."Approver ID" := EscalateTo;
//                 ApprovalEntry."Escalated By" := userIDEsc;
//                 ApprovalEntry."Escalated On" := Today();
//                 ApprovalEntry.Modify();
//                 Message('Document has been Escalated to: %1', EscalateTo);
//             end else
//                 Message('The Document has not been escalate');
//         end;
//     end;

//     procedure CancelPurchaseApprovalRequestFM(FormHeader1: Record "Form Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         FormHeader: Record "Form Header";
//     begin
//         FormHeader.Reset();
//         FormHeader.SetRange(FormHeader."No.", FormHeader1."No.");
//         FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
//         if FormHeader.FindFirst() then begin
//             ApprovalEntry.Reset();
//             ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader1."No.");
//             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
//             if ApprovalEntry.FindFirst() then begin
//                 repeat
//                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                     ApprovalEntry."Last Modified By User ID" := UserId;
//                     ApprovalEntry.Modify();
//                 until ApprovalEntry.Next() = 0;
//             end;
//             FormHeader.Status := FormHeader.Status::Open;
//             FormHeader.Modify();
//         end;
//         Message('The Request has been Cancelled');
//     end;

//     procedure ReopenApprovalEntriesFM(FormHeader: Record "Form Header")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetUp: Record "User Setup";
//         VoucherAdmin: Boolean;
//     begin
//         if not (FormHeader.Status = FormHeader.Status::Open) then
//             exit;

//         VoucherAdmin := false;
//         UserSetUp.Reset();
//         UserSetUp.SetRange(UserSetUp."User ID", UserId);
//         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
//         if UserSetUp.FindFirst() then
//             VoucherAdmin := true;

//         if VoucherAdmin then begin
//             if FormHeader.Status = FormHeader.Status::Open then begin
//                 ApprovalEntry.Reset();
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
//                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             end;
//         end;
//     end;

//     //===============Approval workflow mgt for Cash Purchase================

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
//     local procedure OnAfterGetPageIDCP(RecordRef: RecordRef; var PageID: Integer)
//     begin
//         if PageID = 0 then
//             PageID := GetConditionalCardPageIDCP(RecordRef);
//     end;

//     local procedure GetConditionalCardPageIDCP(RecordRef: RecordRef): Integer
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         if RecordRef.Number = Database::"Cash Purchase" then begin
//             RecordRef.SetTable(CashPurchaseRec);
//             exit(PAGE::"Cash Purchase");
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
//     local procedure OnOpenDocumentCP(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         case RecRef.Number of
//             Database::"Cash Purchase":
//                 begin
//                     RecRef.SetTable(CashPurchaseRec);
//                     CashPurchaseRec.Status := CashPurchaseRec.Status::Open;
//                     CashPurchaseRec.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
//     local procedure OnReleaseDocumentCP(RecRef: RecordRef; var Handled: Boolean)
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         case RecRef.Number of
//             Database::"Cash Purchase":
//                 begin
//                     RecRef.SetTable(CashPurchaseRec);
//                     CashPurchaseRec.Status := CashPurchaseRec.Status::Released;
//                     CashPurchaseRec.Modify();
//                     Handled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
//     procedure OnSetStatusToPendingApprovalCP(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         case RecRef.Number of
//             Database::"Cash Purchase":
//                 begin
//                     RecRef.SetTable(CashPurchaseRec);
//                     CashPurchaseRec.Status := CashPurchaseRec.Status::"Pending approval";
//                     CashPurchaseRec.Modify();
//                     IsHandled := true;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
//     local procedure OnAddWorkflowResponsePredecessorsToLibraryCP(ResponseFunctionName: Code[128])
//     var
//         WorkflowResponseHandling: Codeunit 1521;
//         WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
//     begin
//         case ResponseFunctionName of
//             WorkflowResponseHandling.SetStatusToPendingApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeCP);
//             WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeCP);
//             WorkflowResponseHandling.CancelAllApprovalRequestsCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeCP);
//             WorkflowResponseHandling.OpenDocumentCode:
//                 WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
//                     WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeCP);
//         end;
//     end;

//     procedure CheckClaimApprovalsWorkflowEnableCP(var CashPurchaseRec: Record "Cash Purchase"): Boolean
//     begin
//         if not IsClaimDocApprovalsWorkflowEnableCP(CashPurchaseRec) then
//             Error(NoWorkflowEnabledErrCP);
//         exit(true);
//     end;

//     procedure IsClaimDocApprovalsWorkflowEnableCP(var CashPurchaseRec: Record "Cash Purchase"): Boolean
//     begin
//         if CashPurchaseRec.Status <> CashPurchaseRec.Status::Open then
//             exit(false);
//         exit(WorkflowManagementCP.CanExecuteWorkflow(CashPurchaseRec, WorkflowEventHandlingCustCP.RunWorkflowOnSendClaimForApprovalCodeCP));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     local procedure OnPopulateApprovalEntryArgumentCP(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         case RecRef.Number of
//             Database::"Cash Purchase":
//                 begin
//                     RecRef.SetTable(CashPurchaseRec);
//                     ApprovalEntryArgument."Document No." := CashPurchaseRec."No.";
//                     ApprovalEntryArgument."Prepared By" := CashPurchaseRec."User ID";
//                     ApprovalEntryArgument."Posting Date" := CashPurchaseRec."Document Date";
//                 end;
//         end;
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendClaimForApprovalCP(var CashPurchase: Record "Cash Purchase")
//     begin
        
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelClaimForApprovalCP(var CashPurchase: Record "Cash Purchase")
//     begin
//     end;

//     procedure ReOpenLoanAdvanceCP(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenLoanAdvanceCP(Variant);
//                 end;
//             DATABASE::"Cash Purchase":
//                 begin
//                     RecRef.SetTable(CashPurchaseRec);
//                     CashPurchaseRec.Validate(Status, CashPurchaseRec.Status::Open);
//                     CashPurchaseRec.Modify();
//                     Variant := CashPurchaseRec;
//                 end;
//         end;
//     end;

//     procedure modifyApprovalEntryCP(CashPurchaseRec: Record "Cash Purchase")
//     var
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", CashPurchaseRec."No.");
//         ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
//         if ApprovalEntry.FindFirst() then
//             repeat
//                 ApprovalEntry."Prepared By" := CashPurchaseRec."User ID";
//                 ApprovalEntry."Posting Date" := CashPurchaseRec."Document Date";
//                 ApprovalEntry."Shortcut Dimension 1 Code" := CashPurchaseRec."Shortcut Dimension 1 Code";
//                 ApprovalEntry."Shortcut Dimension 2 Code" := CashPurchaseRec."Shortcut Dimension 2 Code";
//                 ApprovalEntry.Modify();
//             until ApprovalEntry.Next() = 0;
//     end;

//     procedure OpenApprovalEntriesCP(Rec: Record "Cash Purchase")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         SequenceNo: Integer;
//     begin
//         SequenceNo := 0;
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
//         if ApprovalEntries.FindFirst() then begin
//             SequenceNo := ApprovalEntries."Sequence No." + 1;
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
//             ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
//             if ApprovalEntries1.FindFirst() then begin
//                 ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
//                 ApprovalEntries1.Modify();
//             end;
//         end;
//     end;

//     procedure RejectApprovalRequestCP(Rec: Record "Cash Purchase")
//     var
//         ApprovalEntries: Record "Approval Entry";
//         ApprovalEntries1: Record "Approval Entry";
//         NvText: Label 'The approval Request has been rejected';
//     begin
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
//         ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
//         ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
//         if ApprovalEntries.FindFirst() then begin
//             ApprovalEntries1.Reset();
//             ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
//             ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
//             ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
//             ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
//             if ApprovalEntries1.FindFirst() then begin
//                 repeat
//                     ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
//                     ApprovalEntries1.Modify();
//                 until ApprovalEntries1.Next() = 0;
//             end;
//             OpenDocumentCP(Rec);
//             Message(NvText);
//         end;
//     end;

//     procedure OpenDocumentCP(Rec: Record "Cash Purchase")
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         CashPurchaseRec.Reset();
//         CashPurchaseRec.SetRange(CashPurchaseRec."No.", Rec."No.");
//         CashPurchaseRec.SetRange(CashPurchaseRec.Status, CashPurchaseRec.Status::"Pending Approval");
//         if CashPurchaseRec.FindFirst() then begin
//             CashPurchaseRec.Status := CashPurchaseRec.Status::Open;
//             CashPurchaseRec.Modify();
//         end;
//     end;

//     procedure DelegatePurchaseApprovalRequestCP(CashPurchaseRec: Record "Cash Purchase")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetup: Record "User Setup";
//         Txt00003: Label 'Are you sure you want to delegate to:';
//         MessageToSend: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", CashPurchaseRec."No.");
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             UserSetup.Reset();
//             UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
//             if UserSetup.FindFirst() then begin
//                 if UserSetup.Substitute <> '' then begin
//                     MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
//                     if Confirm(MessageToSend, true) then begin
//                         ApprovalEntry."Approver ID" := UserSetup.Substitute;
//                         ApprovalEntry."Last Modified By User ID" := UserId;
//                         ApprovalEntry.Modify();
//                         Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
//                     end;
//                 end else begin
//                     Error('Substitute can not be empty. Contact your Systems Administrator');
//                 end;
//             end else begin
//                 Error('You are not setup please consult your System Administrator');
//             end;
//         end else begin
//             Error('You are not allowed to Delegate please contact your system Administrator');
//         end;
//     end;

//     procedure escalateDocCP(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; CashPurchaseRec: Record "Cash Purchase")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         Txt0010: Label 'Are you sure you want to escalate to';
//         SendMessage: Text[100];
//     begin
//         ApprovalEntry.Reset();
//         ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
//         ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
//         ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
//         ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
//         if ApprovalEntry.FindFirst() then begin
//             SendMessage := Txt0010 + ' ' + EscalateTo;
//             if Confirm(SendMessage, true) then begin
//                 ApprovalEntry."Approver ID" := EscalateTo;
//                 ApprovalEntry."Escalated By" := userIDEsc;
//                 ApprovalEntry."Escalated On" := Today();
//                 ApprovalEntry.Modify();
//                 Message('Document has been Escalated to: %1', EscalateTo);
//             end else
//                 Message('The Document has not been escalate');
//         end;
//     end;

//     procedure CancelPurchaseApprovalRequestCP(CashPurchaseRec1: Record "Cash Purchase")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         CashPurchaseRec.Reset();
//         CashPurchaseRec.SetRange(CashPurchaseRec."No.", CashPurchaseRec1."No.");
//         CashPurchaseRec.SetRange(CashPurchaseRec.Status, CashPurchaseRec.Status::"Pending Approval");
//         if CashPurchaseRec.FindFirst() then begin
//             ApprovalEntry.Reset();
//             ApprovalEntry.SetRange(ApprovalEntry."Document No.", CashPurchaseRec1."No.");
//             ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
//             if ApprovalEntry.FindFirst() then begin
//                 repeat
//                     ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                     ApprovalEntry."Last Modified By User ID" := UserId;
//                     ApprovalEntry.Modify();
//                 until ApprovalEntry.Next() = 0;
//             end;
//             CashPurchaseRec.Status := CashPurchaseRec.Status::Open;
//             CashPurchaseRec.Modify();
//         end;
//         Message('The Request has been Cancelled');
//     end;

//     procedure ReopenApprovalEntriesCP(CashPurchaseRec: Record "Cash Purchase")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         UserSetUp: Record "User Setup";
//         VoucherAdmin: Boolean;
//     begin
//         if not (CashPurchaseRec.Status = CashPurchaseRec.Status::Open) then
//             exit;

//         VoucherAdmin := false;
//         UserSetUp.Reset();
//         UserSetUp.SetRange(UserSetUp."User ID", UserId);
//         UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
//         if UserSetUp.FindFirst() then
//             VoucherAdmin := true;

//         if VoucherAdmin then begin
//             if CashPurchaseRec.Status = CashPurchaseRec.Status::Open then begin
//                 ApprovalEntry.Reset();
//                 ApprovalEntry.SetRange(ApprovalEntry."Document No.", CashPurchaseRec."No.");
//                 ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
//                 if ApprovalEntry.FindFirst() then
//                     repeat
//                         ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
//                         ApprovalEntry.Modify();
//                     until ApprovalEntry.Next() = 0;
//             end;
//         end;
//     end;

//     //===============End Approval workflow mgt for Cash Purchase================

//     //Attachments =============

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
//     local procedure OnBeforeDrillDownDocMR(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         ADTRequisition: Record "Maintenance Header";
//     begin
//         case DocumentAttachment."Table ID" of
//             Database::"Maintenance Header":
//                 begin
//                     RecRef.Open(Database::"Maintenance Header");
//                     ADTRequisition.Reset();
//                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
//                     if ADTRequisition.FindFirst() then
//                         RecRef.GetTable(ADTRequisition);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
//     local procedure OnAfterOpenForRecRefDocMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
//     var
//         FRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         case RecRef.Number of
//             Database::"Maintenance Header":
//                 begin
//                     FRef := RecRef.Field(1);
//                     RecNo := FRef.Value;
//                     DocumentAttachment.SetRange("No.", RecNo);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
//     local procedure OnAfterInitFieldsFromRecRefMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         FieldRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         if RecRef.Number = Database::"Maintenance Header" then begin
//             FieldRef := RecRef.Field(1);
//             RecNo := FieldRef.Value();
//             DocumentAttachment.Validate("No.", RecNo);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
//     local procedure OnBeforeDrillDownDocFM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         ADTRequisition: Record "Form Header";
//     begin
//         case DocumentAttachment."Table ID" of
//             Database::"Form Header":
//                 begin
//                     RecRef.Open(Database::"Form Header");
//                     ADTRequisition.Reset();
//                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
//                     if ADTRequisition.FindFirst() then
//                         RecRef.GetTable(ADTRequisition);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
//     local procedure OnAfterOpenForRecRefDocFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
//     var
//         FRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         case RecRef.Number of
//             Database::"Form Header":
//                 begin
//                     FRef := RecRef.Field(1);
//                     RecNo := FRef.Value;
//                     DocumentAttachment.SetRange("No.", RecNo);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
//     local procedure OnAfterInitFieldsFromRecRefPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         FieldRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         if RecRef.Number = Database::"Form Header" then begin
//             FieldRef := RecRef.Field(1);
//             RecNo := FieldRef.Value();
//             DocumentAttachment.Validate("No.", RecNo);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
//     local procedure OnBeforeDrillDownDocPM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         PerformanceHeader: Record "Performance Header";
//     begin
//         case DocumentAttachment."Table ID" of
//             Database::"Performance Header":
//                 begin
//                     RecRef.Open(Database::"Performance Header");
//                     PerformanceHeader.Reset();
//                     PerformanceHeader.SetRange("No.", DocumentAttachment."No.");
//                     if PerformanceHeader.FindFirst() then
//                         RecRef.GetTable(PerformanceHeader);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
//     local procedure OnAfterOpenForRecRefDocPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
//     var
//         FRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         case RecRef.Number of
//             Database::"Performance Header":
//                 begin
//                     FRef := RecRef.Field(1);
//                     RecNo := FRef.Value;
//                     DocumentAttachment.SetRange("No.", RecNo);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
//     local procedure OnAfterInitFieldsFromRecRefFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         FieldRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         if RecRef.Number = Database::"Performance Header" then begin
//             FieldRef := RecRef.Field(1);
//             RecNo := FieldRef.Value();
//             DocumentAttachment.Validate("No.", RecNo);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
//     local procedure OnBeforeDrillDownDoc(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         ADTRequisition: Record "ADT Requisition Header";
//     begin
//         case DocumentAttachment."Table ID" of
//             Database::"ADT Requisition Header":
//                 begin
//                     RecRef.Open(Database::"ADT Requisition Header");
//                     ADTRequisition.Reset();
//                     ADTRequisition.SetRange("No.", DocumentAttachment."No.");
//                     if ADTRequisition.FindFirst() then
//                         RecRef.GetTable(ADTRequisition);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
//     local procedure OnAfterOpenForRecRefDoc(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
//     var
//         FRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         case RecRef.Number of
//             Database::"ADT Requisition Header":
//                 begin
//                     FRef := RecRef.Field(3);
//                     RecNo := FRef.Value;
//                     DocumentAttachment.SetRange("No.", RecNo);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
//     local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         FieldRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         if RecRef.Number = Database::"ADT Requisition Header" then begin
//             FieldRef := RecRef.Field(3);
//             RecNo := FieldRef.Value();
//             DocumentAttachment.Validate("No.", RecNo);
//         end;
//     end;

//     // Document Attachment Events for Cash Purchase
//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
//     local procedure OnBeforeDrillDownDocCP(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         CashPurchaseRec: Record "Cash Purchase";
//     begin
//         case DocumentAttachment."Table ID" of
//             Database::"Cash Purchase":
//                 begin
//                     RecRef.Open(Database::"Cash Purchase");
//                     CashPurchaseRec.Reset();
//                     CashPurchaseRec.SetRange("No.", DocumentAttachment."No.");
//                     if CashPurchaseRec.FindFirst() then
//                         RecRef.GetTable(CashPurchaseRec);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
//     local procedure OnAfterOpenForRecRefDocCP(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
//     var
//         FRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         case RecRef.Number of
//             Database::"Cash Purchase":
//                 begin
//                     FRef := RecRef.Field(1);
//                     RecNo := FRef.Value;
//                     DocumentAttachment.SetRange("No.", RecNo);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
//     local procedure OnAfterInitFieldsFromRecRefCP(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
//     var
//         FieldRef: FieldRef;
//         RecNo: Code[50];
//     begin
//         if RecRef.Number = Database::"Cash Purchase" then begin
//             FieldRef := RecRef.Field(1);
//             RecNo := FieldRef.Value();
//             DocumentAttachment.Validate("No.", RecNo);
//         end;
//     end;

//     // Item Ledger / Value / Vendor Ledger entry updates

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
//     local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
//     begin
//         ItemLedgerEntry."Equipment No." := ItemJournalLine."Equipment No.";
//         ItemLedgerEntry."Equipment Type" := ItemJournalLine."Equipment Type";
//         ItemLedgerEntry."Store Req. No" := ItemJournalLine."Store Req. No";
//         ItemLedgerEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
//         ItemLedgerEntry."Employee No." := ItemJournalLine."Employee No.";
//         ItemLedgerEntry."From Store Req" := ItemJournalLine."From Store Req";
//         ItemLedgerEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
//         ItemLedgerEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
//     local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
//     begin
//         ValueEntry."Equipment No." := ItemJournalLine."Equipment No.";
//         ValueEntry."Equipment Type" := ItemJournalLine."Equipment Type";
//         ValueEntry."Store Req. No" := ItemJournalLine."Store Req. No";
//         ValueEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
//         ValueEntry."Employee No." := ItemJournalLine."Employee No.";
//         ValueEntry."From Store Req" := ItemJournalLine."From Store Req";
//         ValueEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
//         ValueEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitVendLedgEntry', '', false, false)]
//     local procedure OnBeforeInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
//     begin
//         VendorLedgerEntry."Equipment No." := GenJournalLine."Equipment No.";
//         VendorLedgerEntry."Equipment Type" := GenJournalLine."Equipment Type";
//         VendorLedgerEntry."Responsible Employee" := GenJournalLine."Responsible Employee";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeUpdatePurchaseHeader', '', false, false)]
//     local procedure OnBeforeUpdatePurchaseHeader(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; GenJnlLineDocType: Option; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
//     begin
//         VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
//         VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
//         VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
//         VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeItemJnlPostLine, '', false, false)]
//     local procedure OnBeforeItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; var IsHandled: Boolean; WhseReceiptHeader: Record "Warehouse Receipt Header"; WhseShipmentHeader: Record "Warehouse Shipment Header"; TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary; TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
//     begin
//         ItemJournalLine."Equipment No." := PurchaseLine."Equipment No.";
//         ItemJournalLine."Equipment Type" := PurchaseLine."Equipment Type";
//         ItemJournalLine."Store Req. No" := PurchaseHeader."Purchase Requisition No.";
//         ItemJournalLine."Responsible Employee" := PurchaseLine."Responsible Employee";
//         ItemJournalLine."Purchase Requisition No." := PurchaseHeader."Purchase Requisition No.";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
//     local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; EverythingInvoiced: Boolean)
//     var
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//     begin
//         if not PreviewMode then
//             if PurchHeader."Document Type" in [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::Order] then begin
//                 VendorLedgerEntry.Reset();
//                 VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
//                 if VendorLedgerEntry.FindFirst() then begin
//                     VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
//                     VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
//                     VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
//                     VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
//                     VendorLedgerEntry.Modify();
//                 end;
//             end;
//     end;
// }

codeunit 50000 "Fleet Management"
{
    Permissions = tabledata "ADT Requisition Header" = rm,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rm,
                      tabledata "Vendor Ledger Entry" = rm,
                      tabledata "Approval Entry" = rimd;
    trigger OnRun()
    begin

    end;

    var
        Text0001: Label 'There is not enough space to insert extended text lines.';
        GLAcc: Record "G/L Account";
        Items: Record Item;
        Res: Record Resource;
        TmpExtTextLine: Record "Extended Text Line" temporary;
        NextLineNo: Integer;
        LineSpacing: Integer;
        MakeUpdateRequired: Boolean;
        AutoText: Boolean;

        Text000: Label 'Firm Planned %1';
        Text001: Label 'Released %1';
        Text003: Label 'CU99000845: CalculateRemainingQty - Source type missing';
        Text004: Label 'Codeunit 99000845: Illegal FieldFilter parameter';
        Text006: Label 'Outbound,Inbound';
        Text007: Label 'CU99000845 DeleteReserveEntries2: Surplus order tracking double record detected.';
        CalcReservEntry: Record "Reservation Entry";
        CalcReservEntry2: Record "Reservation Entry";
        ForItemLedgEntry: Record "Item Ledger Entry";
        CalcItemLedgEntry: Record "Item Ledger Entry";
        ForSalesLine: Record "Sales Line";
        CalcSalesLine: Record "Sales Line";
        ForPurchLine: Record "Purchase Line";
        CalcPurchLine: Record "Purchase Line";
        ForItemJnlLine: Record "Item Journal Line";
        ForReqLine: Record "Requisition Line";
        CalcReqLine: Record "Requisition Line";
        ForProdOrderLine: Record "Prod. Order Line";
        CalcProdOrderLine: Record "Prod. Order Line";
        ForProdOrderComp: Record "Prod. Order Component";
        CalcProdOrderComp: Record "Prod. Order Component";
        ForPlanningComponent: Record "Planning Component";
        CalcPlanningComponent: Record "Planning Component";
        ForAssemblyHeader: Record "Assembly Header";
        CalcAssemblyHeader: Record "Assembly Header";
        ForAssemblyLine: Record "Assembly Line";
        CalcAssemblyLine: Record "Assembly Line";
        ForTransLine: Record "Transfer Line";
        CalcTransLine: Record "Transfer Line";
        ForServiceLine: Record "Service Line";
        CalcServiceLine: Record "Service Line";
        ForJobPlanningLine: Record "Job Planning Line";
        CalcJobPlanningLine: Record "Job Planning Line";
        ActionMessageEntry: Record "Action Message Entry";
        Item: Record "Item";
        Location: Record "Location";
        MfgSetup: Record "Manufacturing Setup";
        SKU: Record "Stockkeeping Unit";
        ItemTrackingCode: Record "Item Tracking Code";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        CallTrackingSpecification: Record "Tracking Specification";
        ForJobJnlLine: Record "Job Journal Line";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        ReserveReqLine: Codeunit "Req. Line-Reserve";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
        ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
        AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
        AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
        ReservePlanningComponent: Codeunit "Plng. Component-Reserve";
        ReserveServiceInvLine: Codeunit "Service Line-Reserve";
        ReserveTransLine: Codeunit "Transfer Line-Reserve";
        JobPlanningLineReserve: Codeunit "Job Planning Line-Reserve";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        CreatePick: Codeunit "Create Pick";
        Positive: Boolean;
        CurrentBindingIsSet: Boolean;
        HandleItemTracking: Boolean;
        InvSearch: Text[1];
        FieldFilter: Text[80];
        InvNextStep: Integer;
        ValueArray: array[18] of Integer;
        CurrentBinding: Option "Order-to-Order";
        ItemTrackingHandling: Option "None","Allow deletion",Match;
        Text008: Label 'Item tracking defined for item %1 in the %2 accounts for more than the quantity you have entered.\You must adjust the existing item tracking and then reenter the new quantity.';
        Text009: Label 'Item Tracking cannot be fully matched.\Serial No.: %1, Lot No.: %2, outstanding quantity: %3.';
        Text010: Label 'Item tracking is defined for item %1 in the %2.\You must delete the existing item tracking before modifying or deleting the %2.';
        TotalAvailQty: Decimal;
        QtyAllocInWhse: Decimal;
        QtyOnOutBound: Decimal;
        Text011: Label 'Item tracking is defined for item %1 in the %2.\Do you want to delete the %2 and the item tracking lines?';
        QtyReservedOnPickShip: Decimal;
        Text012: Label 'Assembly';
        "==CMM==": Integer;
        ForNFLReqLine: Record "ADT Requisition Line";

        //=============PurchInfoPaneMgt=================
        Vend: Record Vendor;
        PurchHeader: Record "ADT Requisition Header";
        Text00011: Label 'The Ship-to Address has been changed.';

        //==========================NFL Purch. Price Calc. Mgt.=======================
        GLSetup: Record "General Ledger Setup";
        ResCost: Record "Resource Cost";
        Currency: Record Currency;
        TempPurchPrice: Record "Purchase Price" temporary;
        TempPurchLineDisc: Record "Purchase Line Discount" temporary;
        ResFindUnitCost: Codeunit "Resource-Find Cost";
        LineDiscPerCent: Decimal;
        Qty: Decimal;
        QtyPerUOM: Decimal;
        VATPerCent: Decimal;
        PricesInclVAT: Boolean;
        VATBusPostingGr: Code[10];
        PricesInCurrency: Boolean;
        PriceInSKU: Boolean;
        CurrencyFactor: Decimal;
        ExchRateDate: Date;
        FoundPurchPrice: Boolean;
        DateCaption: Text[30];
        Text020: Label '%1 is less than %2 in the %3.';
        Text030: Label 'Cost including VAT cannot be calculated when %1 is %2.';
        Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
        Text040: Label 'The %1 in the %2 must be same as in the %3.';
        RecRef: RecordRef;
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';


        //========Approval Workflow Management - PRQ========
        WorkflowManagementPRQ: Codeunit 1501;
        WorkflowEventHandlingCustPRQ: Codeunit "Workflow EventHandling Ext";
        NoWorkflowEnabledErrPRQ: TextConst ENU = 'No Approval Workflow for the type is enabled';

        //========Approval Workflow Management - MR========
        WorkflowManagementMR: Codeunit 1501;
        WorkflowEventHandlingCustMR: Codeunit "Workflow EventHandling Ext";
        NoWorkflowEnabledErrMR: TextConst ENU = 'No Approval Workflow for the type is enabled';

        //================Form approval===
        WorkflowManagementFM: Codeunit 1501;
        WorkflowEventHandlingCustFM: Codeunit "Workflow EventHandling Ext";
        NoWorkflowEnabledErrFM: TextConst ENU = 'No Approval Workflow for the type is enabled';

    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]): Integer
    var
        EditDimSetEntries: Page "Edit Dimension Set Entries";
        NewDimSetID: Integer;
        DimSetEntry: Record "Dimension Set Entry";
        dimensionMgt: Codeunit DimensionManagement;
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        dimensionMgt.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        DimSetEntry.RESET;
        EXIT(NewDimSetID);
    end;

    procedure TotalControlsUpdateStyle(RefreshMessageEnabled: Boolean; VAR ControlStyle: Text; VAR RefreshMessageText: Text)
    var
        RefreshMsgTxt: TextConst ENU = 'Totals or discounts may not be up-to-date. Choose the link to update.';
    begin
        IF RefreshMessageEnabled THEN BEGIN
            ControlStyle := 'Subordinate';
            RefreshMessageText := RefreshMsgTxt;
        END ELSE BEGIN
            ControlStyle := 'Strong';
            RefreshMessageText := '';
        END;
    end;

    procedure CreateBookAndOpenExcel(SheetName: Text[250]; ReportHeader: Text[80]; CompanyName: Text[30]; UserID2: Text)
    var
        ExcelBuffer: Record "Excel Buffer";
    begin
        ExcelBuffer.WriteSheet(ReportHeader, CompanyName, UserID2);
        ExcelBuffer.CloseBook;
        ExcelBuffer.OpenExcel;
    end;

    procedure TransferQty()
    var
        PurchaseRequisitionLines: Record "ADT Requisition Line";
    begin
        PurchaseRequisitionLines.Reset();
        PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
        if PurchaseRequisitionLines.FindFirst() then
            repeat
                PurchaseRequisitionLines."Save Qty. to Order" := PurchaseRequisitionLines.Quantity;
                PurchaseRequisitionLines.Modify();
            until PurchaseRequisitionLines.Next() = 0;
    end;

    procedure FillinQtyToOrder()
    var
        PurchaseRequisitionLines: Record "ADT Requisition Line";
    begin
        PurchaseRequisitionLines.Reset();
        PurchaseRequisitionLines.SetRange(PurchaseRequisitionLines.Finished, false);
        if PurchaseRequisitionLines.FindFirst() then
            repeat
                PurchaseRequisitionLines."Qty. to Order" := PurchaseRequisitionLines."Save Qty. to Order";
                PurchaseRequisitionLines.Modify();
            until PurchaseRequisitionLines.Next() = 0;
    end;

    procedure PurchCheckIfAnyExtText(var PurchLine: Record "ADT Requisition Line"; Unconditionally: Boolean): Boolean;
    var
        PurchHeader: Record "ADT Requisition Header";
        ExtTextHeader: Record "Extended Text Header";
    begin
        MakeUpdateRequired := FALSE;
        IF PurchLine."Line No." <> 0 THEN
            MakeUpdateRequired := DeletePurchLines(PurchLine);

        AutoText := FALSE;

        IF Unconditionally THEN
            AutoText := TRUE
        ELSE
            CASE PurchLine.Type OF
                PurchLine.Type::" ":
                    AutoText := TRUE;
                PurchLine.Type::"G/L Account":
                    BEGIN
                        IF GLAcc.GET(PurchLine."No.") THEN
                            AutoText := GLAcc."Automatic Ext. Texts";
                    END;
                PurchLine.Type::Item:
                    BEGIN
                        IF Items.GET(PurchLine."No.") THEN
                            AutoText := Items."Automatic Ext. Texts";
                    END;
            END;

        IF AutoText THEN BEGIN
            PurchLine.TESTFIELD("Document No.");
            PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
            ExtTextHeader.SETRANGE("Table Name", PurchLine.Type);
            ExtTextHeader.SETRANGE("No.", PurchLine."No.");
            CASE PurchLine."Document Type" OF
                PurchLine."Document Type"::"Store Requisition":
                    ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
                PurchLine."Document Type"::"Purchase Requisition":
                    ExtTextHeader.SETRANGE("Purchase Quote", TRUE);
            END;
            EXIT(ReadLines(ExtTextHeader, PurchHeader."Document Date", PurchHeader."Language Code"));
        END;
    end;

    procedure InsertPurchExtText(var PurchLine: Record "ADT Requisition Line");
    var
        ToPurchLine: Record "ADT Requisition Line";
    begin
        ToPurchLine.RESET;
        ToPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
        ToPurchLine.SETRANGE("Document No.", PurchLine."Document No.");
        ToPurchLine := PurchLine;
        IF ToPurchLine.FIND('>') THEN BEGIN
            LineSpacing :=
              (ToPurchLine."Line No." - PurchLine."Line No.") DIV
              (1 + TmpExtTextLine.COUNT);
            IF LineSpacing = 0 THEN
                ERROR(Text0001);
        END ELSE
            LineSpacing := 10000;

        NextLineNo := PurchLine."Line No." + LineSpacing;

        TmpExtTextLine.RESET;
        IF TmpExtTextLine.FIND('-') THEN BEGIN
            REPEAT
                ToPurchLine.INIT;
                ToPurchLine."Document Type" := PurchLine."Document Type";
                ToPurchLine."Document No." := PurchLine."Document No.";
                ToPurchLine."Line No." := NextLineNo;
                NextLineNo := NextLineNo + LineSpacing;
                ToPurchLine.Description := TmpExtTextLine.Text;
                ToPurchLine."Attached to Line No." := PurchLine."Line No.";
                ToPurchLine.INSERT;
            UNTIL TmpExtTextLine.NEXT = 0;
            MakeUpdateRequired := TRUE;
        END;
        TmpExtTextLine.DELETEALL;
    end;

    procedure DeletePurchLines(var PurchLine: Record "ADT Requisition Line"): Boolean;
    var
        PurchLine2: Record "ADT Requisition Line";
    begin
        PurchLine2.SETRANGE("Document Type", PurchLine."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchLine."Document No.");
        PurchLine2.SETRANGE("Attached to Line No.", PurchLine."Line No.");
        PurchLine2 := PurchLine;
        IF PurchLine2.FIND('>') THEN BEGIN
            REPEAT
                PurchLine2.DELETE(TRUE);
            UNTIL PurchLine2.NEXT = 0;
            EXIT(TRUE);
        END;
    end;

    procedure MakeUpdate(): Boolean;
    begin
        EXIT(MakeUpdateRequired);
    end;

    local procedure ReadLines(var ExtTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]): Boolean;
    var
        ExtTextLine: Record "Extended Text Line";
    begin
        ExtTextHeader.SETCURRENTKEY(
          "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtTextHeader.SETRANGE("Starting Date", 0D, DocDate);
        ExtTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
        IF LanguageCode = '' THEN BEGIN
            ExtTextHeader.SETRANGE("Language Code", '');
            IF NOT ExtTextHeader.FIND('+') THEN
                EXIT;
        END ELSE BEGIN
            ExtTextHeader.SETRANGE("Language Code", LanguageCode);
            IF NOT ExtTextHeader.FIND('+') THEN BEGIN
                ExtTextHeader.SETRANGE("All Language Codes", TRUE);
                ExtTextHeader.SETRANGE("Language Code", '');
                IF NOT ExtTextHeader.FIND('+') THEN
                    EXIT;
            END;
        END;

        ExtTextLine.SETRANGE("Table Name", ExtTextHeader."Table Name");
        ExtTextLine.SETRANGE("No.", ExtTextHeader."No.");
        ExtTextLine.SETRANGE("Language Code", ExtTextHeader."Language Code");
        ExtTextLine.SETRANGE("Text No.", ExtTextHeader."Text No.");
        IF ExtTextLine.FIND('-') THEN BEGIN
            TmpExtTextLine.DELETEALL;
            REPEAT
                TmpExtTextLine := ExtTextLine;
                TmpExtTextLine.INSERT;
            UNTIL ExtTextLine.NEXT = 0;
            EXIT(TRUE);
        END;
    end;

    procedure SetRequisitionLine(NewReqLine: Record "ADT Requisition Line")
    var
        CalcReserveEntry: Record "Reservation Entry";
        CalcReserveEntry2: Record "Reservation Entry";
        ForItemLedgEntry: Record "Item Ledger Entry";
        CalcItemLedgEntry: Record "Item Ledger Entry";
        ForSalesLine: Record "Sales Line";
        CalcSalesLine: Record "Sales Line";
        ForPurchLine: Record "Purchase Line";
        CalcPurchLine: Record "Purchase Line";
        ForItemJnlLine: Record "Item Journal Line";
        ForReqLine: Record "Requisition Line";
        CalcReqLine: Record "Requisition Line";
        ForProdOrderLine: Record "Prod. Order Line";
        CalcProdOrderLine: Record "Prod. Order Line";
        ForProdOrderComp: Record "Prod. Order Component";
        CalcProdOrderComp: Record "Prod. Order Component";
        ForPlanningComponent: Record "Planning Component";
        CalcPlanningComponent: Record "Planning Component";
        ForAssemblyHeader: Record "Assembly Header";
        CalcAssemblyHeader: Record "Assembly Header";
        ForAssemblyLine: Record "Assembly Line";
        CalcAssemblyLine: Record "Assembly Line";
        ForTransLine: Record "Transfer Line";
        CalcTransLine: Record "Transfer Line";
        ForServiceLine: Record "Service Line";
        CalcServiceLine: Record "Service Line";
        ForJobPlanningLine: Record "Job Planning Line";
        CalcJobPlanningLine: Record "Job Planning Line";
        ActionMessageEntry: Record "Action Message Entry";
        ForNFLReqLine: Record "ADT Requisition Line";
        Location: Record Location;
        TempTrackingSpecification: Record "Tracking Specification";
        ReservationManagement: Codeunit "Reservation Management";
    begin
        CLEARALL;
        TempTrackingSpecification.DELETEALL;

        ForNFLReqLine := NewReqLine;

        CalcReserveEntry."Source Subtype" := ForNFLReqLine."Document Type";
        CalcReserveEntry."Source ID" := NewReqLine."Document No.";
        CalcReserveEntry."Source Ref. No." := NewReqLine."Line No.";

        IF NewReqLine.Type = NewReqLine.Type::Item THEN
            CalcReserveEntry."Item No." := NewReqLine."No.";
        CalcReserveEntry."Variant Code" := NewReqLine."Variant Code";
        CalcReserveEntry."Location Code" := NewReqLine."Location Code";
        CalcReserveEntry."Serial No." := '';
        CalcReserveEntry."Lot No." := '';
        CalcReserveEntry."Qty. per Unit of Measure" := NewReqLine."Qty. per Unit of Measure";
        CalcReserveEntry."Expected Receipt Date" := NewReqLine."Planned Receipt Date";
        CalcReserveEntry."Shipment Date" := NewReqLine."Planned Receipt Date";
        CalcReserveEntry.Description := NewReqLine.Description;
        CalcReserveEntry2 := CalcReserveEntry;
        IF (CalcReserveEntry."Location Code" <> '') AND
           Location.GET(CalcReserveEntry."Location Code") AND
           (Location."Bin Mandatory" OR Location."Require Pick")
        THEN;
    end;

    procedure PurchaseLines(PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        PurchaseLines: Record "Purchase Line";
    begin
        WITH PurchaseLines DO BEGIN
            SETCURRENTKEY("Document Type", "Document No.");
            SETRANGE("Document Type", PurchaseHeader."Document Type");
            SETRANGE("Document No.", PurchaseHeader."No.");
            IF FINDSET THEN
                REPEAT
                    IF (Quantity <> 0) AND ("Line Amount" <> 0) THEN
                        EXIT(TRUE);
                UNTIL NEXT = 0;
        END;
        EXIT(FALSE);
    end;

    procedure CalcNoOfDocuments(var Vend: Record Vendor);
    begin
        Vend.CALCFIELDS(
          "No. of Quotes", "No. of Blanket Orders", "No. of Orders", "No. of Invoices",
          "No. of Return Orders", "No. of Credit Memos", "No. of Pstd. Return Shipments", "No. of Pstd. Invoices",
          "No. of Pstd. Receipts", "No. of Pstd. Credit Memos",
          "Buy-from No. Of Archived Doc.");
    end;

    procedure CalcTotalNoOfDocuments(VendNo: Code[20]): Integer;
    begin
        GetVend(VendNo);
        WITH Vend DO BEGIN
            CalcNoOfDocuments(Vend);
            EXIT(
              "No. of Quotes" + "No. of Blanket Orders" + "No. of Orders" + "No. of Invoices" +
              "No. of Return Orders" + "No. of Credit Memos" +
              "No. of Pstd. Receipts" + "No. of Pstd. Invoices" +
              "No. of Pstd. Return Shipments" + "No. of Pstd. Credit Memos" +
              "Buy-from No. Of Archived Doc.");
        END;
    end;

    procedure CalcNoOfOrderAddr(VendNo: Code[20]): Integer;
    begin
        GetVend(VendNo);
        Vend.CALCFIELDS("No. of Order Addresses");
        EXIT(Vend."No. of Order Addresses");
    end;

    procedure CalcNoOfContacts(PurchHeader: Record "ADT Requisition Header"): Integer;
    var
        Cont: Record Contact;
        ContBusRelation: Record "Contact Business Relation";
    begin
        Cont.SETCURRENTKEY("Company No.");
        WITH PurchHeader DO
            IF "Buy-from Vendor No." <> '' THEN BEGIN
                IF Cont.GET("Buy-from Contact No.") THEN BEGIN
                    Cont.SETRANGE("Company No.", Cont."Company No.");
                    EXIT(Cont.COUNT);
                END ELSE BEGIN
                    ContBusRelation.RESET;
                    ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
                    ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
                    IF ContBusRelation.FINDFIRST THEN BEGIN
                        Cont.SETRANGE("Company No.", ContBusRelation."Contact No.");
                        EXIT(Cont.COUNT);
                    END ELSE
                        EXIT(0)
                END;
            END;
    end;

    procedure CalcNoOfSubstitutions(var PurchLine: Record "ADT Requisition Line"): Integer;
    begin
        IF GetItem(PurchLine) THEN BEGIN
            Item.CALCFIELDS("No. of Substitutes");
            EXIT(Item."No. of Substitutes");
        END;
    end;

    procedure CalcNoOfPurchasePrices(var PurchLine: Record "ADT Requisition Line"): Integer;
    begin
        IF GetItem(PurchLine) THEN BEGIN
            GetPurchHeader(PurchLine);
            EXIT(NoOfPurchLinePrice(PurchHeader, PurchLine, TRUE));
        END;
    end;

    procedure CalcNoOfPurchLineDisc(var PurchLine: Record "ADT Requisition Line"): Integer;
    begin
        IF GetItem(PurchLine) THEN BEGIN
            GetPurchHeader(PurchLine);
            EXIT(NoOfPurchLineLineDisc(PurchHeader, PurchLine, TRUE));
        END;
    end;

    procedure DocExist(CurrentPurchHeader: Record "ADT Requisition Header"; VendNo: Code[20]): Boolean;
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShipment: Record "Return Shipment Header";
        PurchHeader: Record "ADT Requisition Header";
    begin
        IF VendNo = '' THEN
            EXIT(FALSE);
        WITH PurchInvHeader DO BEGIN
            SETCURRENTKEY("Buy-from Vendor No.");
            SETRANGE("Buy-from Vendor No.", VendNo);
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        WITH PurchRcptHeader DO BEGIN
            SETCURRENTKEY("Buy-from Vendor No.");
            SETRANGE("Buy-from Vendor No.", VendNo);
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        WITH PurchCrMemoHeader DO BEGIN
            SETCURRENTKEY("Buy-from Vendor No.");
            SETRANGE("Buy-from Vendor No.", VendNo);
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
        WITH PurchHeader DO BEGIN
            SETCURRENTKEY("Buy-from Vendor No.");
            SETRANGE("Buy-from Vendor No.", VendNo);
            IF FINDFIRST THEN BEGIN
                IF ("Document Type" <> CurrentPurchHeader."Document Type") OR
                   ("No." <> CurrentPurchHeader."No.")
                THEN
                    EXIT(TRUE);
                IF FIND('>') THEN
                    EXIT(TRUE);
            END;
        END;
        WITH ReturnShipment DO BEGIN
            SETCURRENTKEY("Buy-from Vendor No.");
            SETRANGE("Buy-from Vendor No.", VendNo);
            IF NOT ISEMPTY THEN
                EXIT(TRUE);
        END;
    end;

    procedure VendCommentExists(VendNo: Code[20]): Boolean;
    begin
        GetVend(VendNo);
        Vend.CALCFIELDS(Comment);
        EXIT(Vend.Comment);
    end;

    procedure ItemCommentExists(var PurchLine: Record "ADT Requisition Line"): Boolean;
    begin
        IF GetItem(PurchLine) THEN BEGIN
            Item.CALCFIELDS(Comment);
            EXIT(Item.Comment);
        END;
    end;

    procedure LookupOrderAddr(var PurchHeader: Record "ADT Requisition Header");
    var
        OrderAddress: Record "Order Address";
    begin
        WITH PurchHeader DO BEGIN
            OrderAddress.SETRANGE("Vendor No.", "Buy-from Vendor No.");
            IF PAGE.RUNMODAL(0, OrderAddress) = ACTION::LookupOK THEN BEGIN
                VALIDATE("Order Address Code", OrderAddress.Code);
                MODIFY(TRUE);
                MESSAGE(Text00011);
            END;
        END;
    end;

    procedure LookupContacts(var PurchHeader: Record "ADT Requisition Header");
    var
        Cont: Record Contact;
        ContBusRelation: Record "Contact Business Relation";
    begin
        WITH PurchHeader DO BEGIN
            IF "Buy-from Vendor No." <> '' THEN BEGIN
                IF Cont.GET("Buy-from Contact No.") THEN
                    Cont.SETRANGE("Company No.", Cont."Company No.")
                ELSE BEGIN
                    ContBusRelation.RESET;
                    ContBusRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusRelation.SETRANGE("Link to Table", ContBusRelation."Link to Table"::Vendor);
                    ContBusRelation.SETRANGE("No.", "Buy-from Vendor No.");
                    IF ContBusRelation.FINDFIRST THEN
                        Cont.SETRANGE("Company No.", ContBusRelation."Contact No.")
                    ELSE
                        Cont.SETRANGE("No.", '');
                END;

                IF Cont.GET("Buy-from Contact No.") THEN;
            END ELSE
                Cont.SETRANGE("No.", '');
            IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                VALIDATE("Buy-from Contact No.", Cont."No.");
                MODIFY(TRUE);
            END;
        END;
    end;

    procedure LookupItem(PurchLine: Record "ADT Requisition Line");
    begin
        PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
        PurchLine.TESTFIELD("No.");
        GetItem(PurchLine);
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;

    procedure LookupItemComment(PurchLine: Record "ADT Requisition Line");
    var
        CommentLine: Record "Comment Line";
    begin
        IF GetItem(PurchLine) THEN BEGIN
            CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Item);
            CommentLine.SETRANGE("No.", PurchLine."No.");
            PAGE.RUNMODAL(PAGE::"Comment Sheet", CommentLine);
        END;
    end;

    local procedure GetVend(VendNo: Code[20]);
    begin
        IF VendNo <> '' THEN BEGIN
            IF VendNo <> Vend."No." THEN
                IF NOT Vend.GET(VendNo) THEN
                    CLEAR(Vend);
        END ELSE
            CLEAR(Vend);
    end;

    local procedure GetItem(var PurchLine: Record "ADT Requisition Line"): Boolean;
    begin
        WITH Item DO BEGIN
            IF (PurchLine.Type <> PurchLine.Type::Item) OR (PurchLine."No." = '') THEN
                EXIT(FALSE);

            IF PurchLine."No." <> "No." THEN
                GET(PurchLine."No.");
            EXIT(TRUE);
        END;
    end;

    local procedure GetPurchHeader(PurchLine: Record "ADT Requisition Line");
    begin
        IF (PurchLine."Document Type" <> PurchHeader."Document Type") OR
           (PurchLine."Document No." <> PurchHeader."No.")
        THEN
            PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
    end;

    procedure CalcNoOfPayToDocuments(var Vend: Record Vendor);
    begin
        Vend.CALCFIELDS(
          "Pay-to No. of Quotes", "Pay-to No. of Blanket Orders", "Pay-to No. of Orders", "Pay-to No. of Invoices",
          "Pay-to No. of Return Orders", "Pay-to No. of Credit Memos", "Pay-to No. of Pstd. Receipts",
          "Pay-to No. of Pstd. Invoices", "Pay-to No. of Pstd. Return S.", "Pay-to No. of Pstd. Cr. Memos",
          "Pay-to No. Of Archived Doc.");
    end;

    procedure CalcAvailability2(var PurchLine: Record "ADT Requisition Line"): Decimal;
    var
        AvailableToPromise: Codeunit "Available to Promise";
        GrossRequirement: Decimal;
        ScheduledReceipt: Decimal;
        PeriodType: Option Day,Week,Month,Quarter,Year;
        AvailabilityDate: Date;
        LookaheadDateFormula: DateFormula;
        lvItemLedgEntry: Record "Item Ledger Entry";
        lvInvtQty: Decimal;
        lvReservEntry: Record "Reservation Entry";
        lvReservedQty: Decimal;
    begin
        lvInvtQty := 0;
        IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
            lvItemLedgEntry.RESET;
            lvItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
            lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Item No.", PurchLine."No.");
            lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Variant Code", PurchLine."Variant Code");
            lvItemLedgEntry.SETRANGE(lvItemLedgEntry."Location Code", PurchLine."Location Code");
            lvItemLedgEntry.CALCSUMS(lvItemLedgEntry.Quantity);
            lvInvtQty := lvItemLedgEntry.Quantity;

            lvReservEntry.SETCURRENTKEY("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code");
            lvReservEntry.SETRANGE(lvReservEntry."Item No.", PurchLine."No.");
            lvReservEntry.SETFILTER(lvReservEntry."Source Type", '%1', 32);
            lvReservEntry.SETFILTER(lvReservEntry."Source Subtype", '%1', 0);
            lvReservEntry.SETFILTER(lvReservEntry."Reservation Status", '%1', lvReservEntry."Reservation Status"::Reservation);
            lvReservEntry.SETRANGE(lvReservEntry."Location Code", PurchLine."Location Code");
            lvReservEntry.SETRANGE(lvReservEntry."Variant Code", PurchLine."Variant Code");
            lvReservEntry.CALCSUMS(lvReservEntry."Quantity (Base)");
            lvReservedQty := lvReservEntry."Quantity (Base)";
            EXIT(lvInvtQty - lvReservedQty);
        END
        ELSE
            EXIT(lvInvtQty);
    end;

    procedure FindPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; CalledByFieldNo: Integer);
    begin
        WITH PurchLine DO BEGIN
            SetCurrency(
              PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));
            SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
            SetLineDisc("Line Discount %");

            TESTFIELD("Qty. per Unit of Measure");
            IF PricesInCurrency THEN
                PurchHeader.TESTFIELD("Currency Factor");

            CASE Type OF
                Type::Item:
                    BEGIN
                        Item.GET("No.");
                        PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

                        PurchLinePriceExists(PurchHeader, PurchLine, FALSE);
                        CalcBestDirectUnitCost(TempPurchPrice);

                        IF FoundPurchPrice OR
                           NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                                (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
                        THEN
                            "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
                    END;
            END;
        END;
    end;

    procedure FindItemJnlLinePrice(var ItemJnlLine: Record "Item Journal Line"; CalledByFieldNo: Integer);
    begin
        WITH ItemJnlLine DO BEGIN
            TESTFIELD("Qty. per Unit of Measure");
            SetCurrency('', 0, 0D);
            SetVAT(FALSE, 0, '');
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            Item.GET("Item No.");
            PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

            FindPurchPrice(
              TempPurchPrice, '', "Item No.", "Variant Code",
              "Unit of Measure Code", '', "Posting Date", FALSE);
            CalcBestDirectUnitCost(TempPurchPrice);

            IF FoundPurchPrice OR
               NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                    (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
            THEN
                "Unit Amount" := TempPurchPrice."Direct Unit Cost";
        END;
    end;

    procedure FindReqLinePrice(var ReqLine: Record "Requisition Line"; CalledByFieldNo: Integer);
    begin
        WITH ReqLine DO BEGIN
            IF Type = Type::Item THEN BEGIN
                IF NOT Vend.GET("Vendor No.") THEN
                    Vend.INIT;

                SetCurrency("Currency Code", "Currency Factor", "Order Date");
                SetVAT(Vend."Prices Including VAT", 0, '');
                SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

                TESTFIELD("Qty. per Unit of Measure");
                IF PricesInCurrency THEN
                    ReqLine.TESTFIELD("Currency Factor");

                Item.GET("No.");
                PriceInSKU := SKU.GET("Location Code", "No.", "Variant Code");

                FindPurchPrice(
                  TempPurchPrice, "Vendor No.", "No.", "Variant Code",
                  "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
                CalcBestDirectUnitCost(TempPurchPrice);

                IF FoundPurchPrice OR
                   NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                        (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
                THEN
                    "Direct Unit Cost" := TempPurchPrice."Direct Unit Cost";
            END;
        END;
    end;

    procedure FindPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
    begin
        WITH PurchLine DO BEGIN
            SetCurrency(PurchHeader."Currency Code", 0, 0D);
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            TESTFIELD("Qty. per Unit of Measure");

            IF PurchLine.Type = Type::Item THEN BEGIN
                PurchLineLineDiscExists(PurchHeader, PurchLine, FALSE);
                CalcBestLineDisc(TempPurchLineDisc);

                "Line Discount %" := TempPurchLineDisc."Line Discount %";
            END;
        END;
    end;

    procedure FindStdItemJnlLinePrice(var StdItemJnlLine: Record "Standard Item Journal Line"; CalledByFieldNo: Integer);
    begin
        WITH StdItemJnlLine DO BEGIN
            TESTFIELD("Qty. per Unit of Measure");
            SetCurrency('', 0, 0D);
            SetVAT(FALSE, 0, '');
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            Item.GET("Item No.");
            PriceInSKU := SKU.GET("Location Code", "Item No.", "Variant Code");

            FindPurchPrice(
              TempPurchPrice, '', "Item No.", "Variant Code",
              "Unit of Measure Code", '', WORKDATE, FALSE);
            CalcBestDirectUnitCost(TempPurchPrice);

            IF FoundPurchPrice OR
               NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                    (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
            THEN
                "Unit Amount" := TempPurchPrice."Direct Unit Cost";
        END;
    end;

    procedure FindReqLineDisc(var ReqLine: Record "Requisition Line");
    begin
        WITH ReqLine DO BEGIN
            SetCurrency("Currency Code", 0, 0D);
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            TESTFIELD("Qty. per Unit of Measure");

            IF ReqLine.Type = Type::Item THEN BEGIN
                FindPurchLineDisc(
                  TempPurchLineDisc, "Vendor No.", "No.", "Variant Code",
                  "Unit of Measure Code", "Currency Code", "Order Date", FALSE);
                CalcBestLineDisc(TempPurchLineDisc);

                "Line Discount %" := TempPurchLineDisc."Line Discount %";
            END;
        END;
    end;

    local procedure CalcBestDirectUnitCost(var PurchPrice: Record "Purchase Price");
    var
        BestPurchPrice: Record "Purchase Price";
    begin
        WITH PurchPrice DO BEGIN
            FoundPurchPrice := PurchPrice.FIND('-');
            IF FoundPurchPrice THEN
                REPEAT
                    IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN BEGIN
                        ConvertPriceToVAT(
                          Vend."Prices Including VAT", Item."VAT Prod. Posting Group",
                          Vend."VAT Bus. Posting Group", "Direct Unit Cost");
                        ConvertPriceToUoM("Unit of Measure Code", "Direct Unit Cost");
                        ConvertPriceLCYToFCY("Currency Code", "Direct Unit Cost");

                        CASE TRUE OF
                            ((BestPurchPrice."Currency Code" = '') AND ("Currency Code" <> '')) OR
                          ((BestPurchPrice."Variant Code" = '') AND ("Variant Code" <> '')):
                                BestPurchPrice := PurchPrice;
                            ((BestPurchPrice."Currency Code" = '') OR ("Currency Code" <> '')) AND
                          ((BestPurchPrice."Variant Code" = '') OR ("Variant Code" <> '')):
                                IF (BestPurchPrice."Direct Unit Cost" = 0) OR
                                   (CalcLineAmount(BestPurchPrice) > CalcLineAmount(PurchPrice))
                                THEN
                                    BestPurchPrice := PurchPrice;
                        END;
                    END;
                UNTIL NEXT = 0;
        END;

        IF BestPurchPrice."Direct Unit Cost" = 0 THEN BEGIN
            PriceInSKU := PriceInSKU AND (SKU."Last Direct Cost" <> 0);
            IF PriceInSKU THEN
                BestPurchPrice."Direct Unit Cost" := SKU."Last Direct Cost"
            ELSE
                BestPurchPrice."Direct Unit Cost" := Item."Last Direct Cost";

            ConvertPriceToVAT(FALSE, Item."VAT Prod. Posting Group", '', BestPurchPrice."Direct Unit Cost");
            ConvertPriceToUoM('', BestPurchPrice."Direct Unit Cost");
            ConvertPriceLCYToFCY('', BestPurchPrice."Direct Unit Cost");
        END;

        PurchPrice := BestPurchPrice;
    end;

    local procedure CalcBestLineDisc(var PurchLineDisc: Record "Purchase Line Discount");
    var
        BestPurchLineDisc: Record "Purchase Line Discount";
    begin
        WITH PurchLineDisc DO
            IF FIND('-') THEN
                REPEAT
                    IF IsInMinQty("Unit of Measure Code", "Minimum Quantity") THEN
                        CASE TRUE OF
                            ((BestPurchLineDisc."Currency Code" = '') AND ("Currency Code" <> '')) OR
                          ((BestPurchLineDisc."Variant Code" = '') AND ("Variant Code" <> '')):
                                BestPurchLineDisc := PurchLineDisc;
                            ((BestPurchLineDisc."Currency Code" = '') OR ("Currency Code" <> '')) AND
                          ((BestPurchLineDisc."Variant Code" = '') OR ("Variant Code" <> '')):
                                IF BestPurchLineDisc."Line Discount %" < "Line Discount %" THEN
                                    BestPurchLineDisc := PurchLineDisc;
                        END;
                UNTIL NEXT = 0;

        PurchLineDisc := BestPurchLineDisc;
    end;

    procedure FindPurchPrice(var ToPurchPrice: Record "Purchase Price"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
    var
        FromPurchPrice: Record "Purchase Price";
    begin
        WITH FromPurchPrice DO BEGIN
            SETRANGE("Item No.", ItemNo);
            SETRANGE("Vendor No.", VendorNo);
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            SETFILTER("Variant Code", '%1|%2', VariantCode, '');
            IF NOT ShowAll THEN BEGIN
                SETRANGE("Starting Date", 0D, StartingDate);
                SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
                SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            END;

            ToPurchPrice.RESET;
            ToPurchPrice.DELETEALL;
            IF FromPurchPrice.FIND('-') THEN
                REPEAT
                    IF FromPurchPrice."Direct Unit Cost" <> 0 THEN BEGIN
                        ToPurchPrice := FromPurchPrice;
                        ToPurchPrice.INSERT;
                    END;
                UNTIL FromPurchPrice.NEXT = 0;
        END;
    end;

    procedure FindPurchLineDisc(var ToPurchLineDisc: Record "Purchase Line Discount"; VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
    var
        FromPurchLineDisc: Record "Purchase Line Discount";
    begin
        WITH FromPurchLineDisc DO BEGIN
            SETRANGE("Item No.", ItemNo);
            SETRANGE("Vendor No.", VendorNo);
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            SETFILTER("Variant Code", '%1|%2', VariantCode, '');
            IF NOT ShowAll THEN BEGIN
                SETRANGE("Starting Date", 0D, StartingDate);
                SETFILTER("Currency Code", '%1|%2', CurrencyCode, '');
                SETFILTER("Unit of Measure Code", '%1|%2', UOM, '');
            END;

            ToPurchLineDisc.RESET;
            ToPurchLineDisc.DELETEALL;

            IF FIND('-') THEN
                REPEAT
                    IF FromPurchLineDisc."Line Discount %" <> 0 THEN BEGIN
                        ToPurchLineDisc := FromPurchLineDisc;
                        ToPurchLineDisc.INSERT;
                    END;
                UNTIL FromPurchLineDisc.NEXT = 0;
        END;
    end;

    local procedure SetCurrency(CurrencyCode2: Code[10]; CurrencyFactor2: Decimal; ExchRateDate2: Date);
    begin
        PricesInCurrency := CurrencyCode2 <> '';
        IF PricesInCurrency THEN BEGIN
            Currency.GET(CurrencyCode2);
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
            CurrencyFactor := CurrencyFactor2;
            ExchRateDate := ExchRateDate2;
        END ELSE
            GLSetup.GET;
    end;

    local procedure SetVAT(PriceInclVAT2: Boolean; VATPerCent2: Decimal; VATBusPostingGr2: Code[10]);
    begin
        PricesInclVAT := PriceInclVAT2;
        VATPerCent := VATPerCent2;
        VATBusPostingGr := VATBusPostingGr2;
    end;

    local procedure SetUoM(Qty2: Decimal; QtyPerUoM2: Decimal);
    begin
        Qty := Qty2;
        QtyPerUOM := QtyPerUoM2;
    end;

    local procedure SetLineDisc(LineDiscPerCent2: Decimal);
    begin
        LineDiscPerCent := LineDiscPerCent2;
    end;

    local procedure IsInMinQty(UnitOfMeasureCode: Code[10]; MinQty: Decimal): Boolean;
    begin
        IF UnitOfMeasureCode = '' THEN
            EXIT(MinQty <= QtyPerUOM * Qty);
        EXIT(MinQty <= Qty);
    end;

    local procedure ConvertPriceToVAT(FromPriceInclVAT: Boolean; FromVATProdPostingGr: Code[10]; FromVATBusPostingGr: Code[10]; var UnitPrice: Decimal);
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        IF FromPriceInclVAT THEN BEGIN
            IF NOT VATPostingSetup.GET(FromVATBusPostingGr, FromVATProdPostingGr) THEN
                VATPostingSetup.INIT;

            IF PricesInclVAT THEN BEGIN
                IF VATBusPostingGr <> FromVATBusPostingGr THEN
                    UnitPrice := UnitPrice * (100 + VATPerCent) / (100 + VATPostingSetup."VAT %");
            END ELSE
                UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
        END ELSE
            IF PricesInclVAT THEN
                UnitPrice := UnitPrice * (1 + VATPerCent / 100);
    end;

    local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal);
    begin
        IF UnitOfMeasureCode = '' THEN
            UnitPrice := UnitPrice * QtyPerUOM;
    end;

    local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal);
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        IF PricesInCurrency THEN BEGIN
            IF CurrencyCode = '' THEN
                UnitPrice :=
                  CurrExchRate.ExchangeAmtLCYToFCY(ExchRateDate, Currency.Code, UnitPrice, CurrencyFactor);
            UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
        END ELSE
            UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
    end;

    local procedure CalcLineAmount(PurchPrice: Record "Purchase Price"): Decimal;
    begin
        WITH PurchPrice DO
            EXIT("Direct Unit Cost" * (1 - LineDiscPerCent / 100));
    end;

    procedure PurchLinePriceExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
    begin
        WITH PurchLine DO
            IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
                FindPurchPrice(
                  TempPurchPrice, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
                  PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
                EXIT(TempPurchPrice.FIND('-'));
            END;
        EXIT(FALSE);
    end;

    procedure PurchLineLineDiscExists(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Boolean;
    begin
        WITH PurchLine DO
            IF (Type = Type::Item) AND Item.GET("No.") THEN BEGIN
                FindPurchLineDisc(
                  TempPurchLineDisc, "Buy-from Vendor No.", "No.", "Variant Code", "Unit of Measure Code",
                  PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll);
                EXIT(TempPurchLineDisc.FIND('-'));
            END;
        EXIT(FALSE);
    end;

    local procedure PurchHeaderExchDate(PurchHeader: Record "ADT Requisition Header"): Date;
    begin
        WITH PurchHeader DO BEGIN
            IF ("Document Type" IN ["Document Type"::"Store Requisition", "Document Type"::"Purchase Requisition"]) AND
               ("Posting Date" = 0D)
            THEN
                EXIT(WORKDATE);
            EXIT("Posting Date");
        END;
    end;

    local procedure PurchHeaderStartDate(PurchHeader: Record "ADT Requisition Header"; var DateCaption: Text[30]): Date;
    begin
        WITH PurchHeader DO BEGIN
            DateCaption := FIELDCAPTION("Order Date");
            EXIT("Order Date");
        END;
    end;

    procedure FindJobPlanningLinePrice(var JobPlanningLine: Record "Job Planning Line"; CalledByFieldNo: Integer);
    var
        JTHeader: Record Job;
    begin
        WITH JobPlanningLine DO BEGIN
            SetCurrency("Currency Code", "Currency Factor", "Planning Date");
            SetVAT(FALSE, 0, '');
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            TESTFIELD("Qty. per Unit of Measure");

            CASE Type OF
                Type::Item:
                    BEGIN
                        Item.GET("No.");
                        PriceInSKU := SKU.GET('', "No.", "Variant Code");
                        JTHeader.GET("Job No.");

                        FindPurchPrice(
                          TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", '', "Planning Date", FALSE);
                        PricesInCurrency := FALSE;
                        GLSetup.GET;
                        CalcBestDirectUnitCost(TempPurchPrice);
                        SetCurrency("Currency Code", "Currency Factor", "Planning Date");

                        IF FoundPurchPrice OR
                           NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                                (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
                        THEN
                            "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

                    END;
                Type::Resource:
                    BEGIN
                        ResCost.INIT;
                        ResCost.Code := "No.";
                        ResCost."Work Type Code" := "Work Type Code";
                        ResFindUnitCost.RUN(ResCost);

                        ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
                        "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
                        VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
                    END;
            END;
            VALIDATE("Direct Unit Cost (LCY)");
        END;
    end;

    procedure FindJobJnlLinePrice(var JobJnlLine: Record "Job Journal Line"; CalledByFieldNo: Integer);
    var
        JTHeader: Record Job;
    begin
        WITH JobJnlLine DO BEGIN
            SetCurrency("Currency Code", "Currency Factor", "Posting Date");
            SetVAT(FALSE, 0, '');
            SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

            TESTFIELD("Qty. per Unit of Measure");

            CASE Type OF
                Type::Item:
                    BEGIN
                        Item.GET("No.");
                        PriceInSKU := SKU.GET('', "No.", "Variant Code");
                        JTHeader.GET("Job No.");

                        FindPurchPrice(
                          TempPurchPrice, '', "No.", "Variant Code", "Unit of Measure Code", "Country/Region Code", "Posting Date", FALSE);
                        PricesInCurrency := FALSE;
                        GLSetup.GET;
                        CalcBestDirectUnitCost(TempPurchPrice);
                        SetCurrency("Currency Code", "Currency Factor", "Posting Date");

                        IF FoundPurchPrice OR
                           NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                                (((CalledByFieldNo = FIELDNO("Variant Code")) AND NOT PriceInSKU)))
                        THEN
                            "Direct Unit Cost (LCY)" := TempPurchPrice."Direct Unit Cost";

                    END;
                Type::Resource:
                    BEGIN
                        ResCost.INIT;
                        ResCost.Code := "No.";
                        ResCost."Work Type Code" := "Work Type Code";
                        ResFindUnitCost.RUN(ResCost);

                        ConvertPriceLCYToFCY("Currency Code", ResCost."Unit Cost");
                        "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost";
                        VALIDATE("Unit Cost (LCY)", ResCost."Unit Cost");
                    END;
            END;
            VALIDATE("Direct Unit Cost (LCY)");
        END;
    end;

    procedure NoOfPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
    begin
        IF PurchLinePriceExists(PurchHeader, PurchLine, ShowAll) THEN
            EXIT(TempPurchPrice.COUNT);
    end;

    procedure NoOfPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line"; ShowAll: Boolean): Integer;
    begin
        IF PurchLineLineDiscExists(PurchHeader, PurchLine, ShowAll) THEN
            EXIT(TempPurchLineDisc.COUNT);
    end;

    procedure GetPurchLinePrice(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
    begin
        PurchLinePriceExists(PurchHeader, PurchLine, TRUE);

        WITH PurchLine DO
            IF PAGE.RUNMODAL(PAGE::"Get Purchase Price", TempPurchPrice) = ACTION::LookupOK THEN BEGIN

                SetVAT(PurchHeader."Prices Including VAT", "VAT %", "VAT Bus. Posting Group");
                SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
                SetCurrency(
                  PurchHeader."Currency Code", PurchHeader."Currency Factor", PurchHeaderExchDate(PurchHeader));

                IF NOT IsInMinQty(TempPurchPrice."Unit of Measure Code", TempPurchPrice."Minimum Quantity") THEN
                    ERROR(
                      Text020,
                      FIELDCAPTION(Quantity),
                      TempPurchPrice.FIELDCAPTION("Minimum Quantity"),
                      TempPurchPrice.TABLECAPTION);
                IF NOT (TempPurchPrice."Currency Code" IN ["Currency Code", '']) THEN
                    ERROR(
                      Text040,
                      FIELDCAPTION("Currency Code"),
                      TABLECAPTION,
                      TempPurchPrice.TABLECAPTION);
                IF NOT (TempPurchPrice."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
                    ERROR(
                      Text040,
                      FIELDCAPTION("Unit of Measure Code"),
                      TABLECAPTION,
                      TempPurchPrice.TABLECAPTION);
                IF TempPurchPrice."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
                    ERROR(
                      Text020,
                      DateCaption,
                      TempPurchPrice.FIELDCAPTION("Starting Date"),
                      TempPurchPrice.TABLECAPTION);

                ConvertPriceToVAT(
                  PurchHeader."Prices Including VAT", Item."VAT Prod. Posting Group",
                 "VAT Bus. Posting Group", TempPurchPrice."Direct Unit Cost");
                ConvertPriceToUoM("Unit of Measure Code", TempPurchPrice."Direct Unit Cost");
                ConvertPriceLCYToFCY(TempPurchPrice."Currency Code", TempPurchPrice."Direct Unit Cost");

                VALIDATE("Direct Unit Cost", TempPurchPrice."Direct Unit Cost");
            END;
    end;

    procedure GetPurchLineLineDisc(PurchHeader: Record "ADT Requisition Header"; var PurchLine: Record "ADT Requisition Line");
    begin
        PurchLineLineDiscExists(PurchHeader, PurchLine, TRUE);

        WITH PurchLine DO
            IF PAGE.RUNMODAL(PAGE::"Get Purchase Line Disc.", TempPurchLineDisc) = ACTION::LookupOK THEN BEGIN
                SetCurrency(PurchHeader."Currency Code", 0, 0D);
                SetUoM(ABS(Quantity), "Qty. per Unit of Measure");

                IF NOT IsInMinQty(TempPurchLineDisc."Unit of Measure Code", TempPurchLineDisc."Minimum Quantity")
                THEN
                    ERROR(
                      Text020, FIELDCAPTION(Quantity),
                      TempPurchLineDisc.FIELDCAPTION("Minimum Quantity"),
                      TempPurchLineDisc.TABLECAPTION);
                IF NOT (TempPurchLineDisc."Currency Code" IN ["Currency Code", '']) THEN
                    ERROR(
                      Text040,
                      FIELDCAPTION("Currency Code"),
                      TABLECAPTION,
                      TempPurchLineDisc.TABLECAPTION);
                IF NOT (TempPurchLineDisc."Unit of Measure Code" IN ["Unit of Measure Code", '']) THEN
                    ERROR(
                      Text040,
                      FIELDCAPTION("Unit of Measure Code"),
                      TABLECAPTION,
                      TempPurchLineDisc.TABLECAPTION);
                IF TempPurchLineDisc."Starting Date" > PurchHeaderStartDate(PurchHeader, DateCaption) THEN
                    ERROR(
                      Text020,
                      DateCaption,
                      TempPurchLineDisc.FIELDCAPTION("Starting Date"),
                      TempPurchLineDisc.TABLECAPTION);

                VALIDATE("Line Discount %", TempPurchLineDisc."Line Discount %");
            END;
    end;

    //========Approval Workflow Management - PRQ========

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageIDPRQ(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageIDPRQ(RecordRef);
    end;

    local procedure GetConditionalCardPageIDPRQ(RecordRef: RecordRef): Integer
    var
        RequisitionHeader: Record "ADT Requisition Header";
    begin
        RecordRef.SetTable(RequisitionHeader);
        case RequisitionHeader."Document Type" of
            RequisitionHeader."Document Type"::"Purchase Requisition":
                if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
                    exit(PAGE::"Spare Part Requisition");
            RequisitionHeader."Document Type"::"Store Requisition":
                if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
                    exit(PAGE::"Fuel Requisition");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
    var
        Claim: Record "ADT Requisition Header";
    begin
        case RecRef.Number of
            Database::"ADT Requisition Header":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Status := Claim.Status::Open;
                    Claim.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocumentPRQ(RecRef: RecordRef; var Handled: Boolean)
    var
        Claim: Record "ADT Requisition Header";
    begin
        case RecRef.Number of
            Database::"ADT Requisition Header":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Status := Claim.Status::Released;
                    Claim.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApprovalPRQ(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        claim: Record "ADT Requisition Header";
        Cash: Record "cash Purchase";
    begin
        case RecRef.Number of
            Database::"ADT Requisition Header":
                begin
                    RecRef.SetTable(claim);
                    claim.Status := claim.Status::"Pending approval";
                    claim.Modify();
                    IsHandled := true;
                end;
                  Database::"Cash Purchase":
                begin
                    RecRef.SetTable(Cash);
                    Cash.Status := Cash.Status::"Pending approval";
                    Cash.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    procedure CheckBudgetPurchasePRQ(var RequisitionHeader: Record "ADT Requisition Header");
    var
        RequisitionLine: Record "ADT Requisition Line";
    begin
        if RequisitionHeader."Document Type" = RequisitionHeader."Document Type"::"Purchase Requisition" then begin
            RequisitionHeader.TESTFIELD("Shortcut Dimension 1 Code");
            RequisitionLine.RESET;
            IF RequisitionHeader.Status = RequisitionHeader.Status::"Pending Approval" THEN BEGIN
                RequisitionLine.SETRANGE("Document Type", RequisitionHeader."Document Type");
                RequisitionLine.SETRANGE("Document No.", RequisitionHeader."No.");
                IF RequisitionLine.FIND('-') THEN
                    REPEAT
                        IF RequisitionLine.Type = RequisitionLine.Type::"G/L Account" THEN BEGIN
                            if RequisitionLine."G/L Account Type" = RequisitionLine."G/L Account Type"::"Income Statement" then begin
                                IF RequisitionLine."Budget Comment" = 'Out of Budget' THEN BEGIN
                                    ERROR('Purchase Requisition Line %1 is Out of Budget and must be escalated to CFO/CEO!', RequisitionLine."Line No.");
                                END;
                            end;
                        END;
                    UNTIL RequisitionLine.NEXT = 0;
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibraryPRQ(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit 1521;
        WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodePRQ);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodePRQ);
        end;
    end;

    procedure CheckClaimApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
    begin
        if not IsClaimDocApprovalsWorkflowEnablePRQ(Claim) then
            Error(NoWorkflowEnabledErrPRQ);
        exit(true);
    end;

    procedure IsClaimDocApprovalsWorkflowEnablePRQ(var Claim: Record "ADT Requisition Header"): Boolean
    begin
        if Claim.Status <> Claim.Status::Open then
            exit(false);
        exit(WorkflowManagementPRQ.CanExecuteWorkflow(Claim, WorkflowEventHandlingCustPRQ.RunWorkflowOnSendClaimForApprovalCodePRQ));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgumentPRQ(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Claim: Record "ADT Requisition Header";
    begin
        case RecRef.Number of
            Database::"ADT Requisition Header":
                begin
                    RecRef.SetTable(Claim);
                    ApprovalEntryArgument."Document No." := Claim."No.";
                    ApprovalEntryArgument."Requisition Type" := Claim."Document Type"::"Store Requisition";
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelClaimForApprovalPRQ(var Claim: Record "ADT Requisition Header")
    begin
    end;

    procedure ReOpenLoanAdvancePRQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        LoanAdvance: Record "ADT Requisition Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenLoanAdvancePRQ(Variant);
                end;
            DATABASE::Job:
                begin
                    RecRef.SetTable(LoanAdvance);
                    LoanAdvance.Validate(Status, LoanAdvance.Status::Open);
                    LoanAdvance.Modify();
                    Variant := LoanAdvance;
                end;
        end;
    end;

    procedure modifyApprovalEntryPRQ(PurchaseReqHeader: Record "ADT Requisition Header")
    var
        NflRequisitionLine: Record "ADT Requisition Line";
        AmountLcy: Decimal;
        ApprovalEntry: Record "Approval Entry";
    begin
        AmountLcy := 0;
        PurchaseReqHeader.CalcFields("Total Cost");
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseReqHeader."No.");
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindFirst() then
            repeat
                if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Purchase Requisition" then begin
                    ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
                    ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
                    ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
                    ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
                    ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
                    ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
                    ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
                    ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
                    ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
                    ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
                end else
                    if PurchaseReqHeader."Document Type" = PurchaseReqHeader."Document Type"::"Store Requisition" then begin
                        ApprovalEntry."Document Type" := PurchaseReqHeader."Document Type";
                        ApprovalEntry."Requisition Type" := PurchaseReqHeader."Document Type";
                        ApprovalEntry."Prepared By" := PurchaseReqHeader."Prepared by";
                        ApprovalEntry."Currency Code" := PurchaseReqHeader."Currency Code";
                        ApprovalEntry.Amount := PurchaseReqHeader."Total Cost";
                        ApprovalEntry."Payee No." := PurchaseReqHeader."Request-By No.";
                        ApprovalEntry."Payee Name" := PurchaseReqHeader."Request-By Name";
                        ApprovalEntry.Description := PurchaseReqHeader."Posting Description";
                        ApprovalEntry."Posting Date" := PurchaseReqHeader."Posting Date";
                        ApprovalEntry."Shortcut Dimension 1 Code" := PurchaseReqHeader."Shortcut Dimension 1 Code";
                        ApprovalEntry."Shortcut Dimension 2 Code" := PurchaseReqHeader."Shortcut Dimension 2 Code";
                    end;
                ApprovalEntry.Modify();
            until ApprovalEntry.Next() = 0;
    end;

    procedure UpdateApprovalEntryInfoPRQ()
    var
        PurchReq: Record "ADT Requisition Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchReq.Reset();
        PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Purchase Requisition");
        PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
        if PurchReq.FindFirst() then
            repeat
                PurchReq.CalcFields("Total Cost");
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := PurchReq."Document Type";
                        ApprovalEntry."Prepared By" := PurchReq."Prepared by";
                        ApprovalEntry."Currency Code" := PurchReq."Currency Code";
                        ApprovalEntry."Payee No." := PurchReq."Request-By No.";
                        ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
                        ApprovalEntry.Description := PurchReq."Posting Description";
                        ApprovalEntry."Posting Date" := PurchReq."Posting Date";
                        ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
                        ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until PurchReq.Next() = 0;

        PurchReq.Reset();
        PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
        PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
        if PurchReq.FindFirst() then
            repeat
                PurchReq.CalcFields("Total Cost");
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := PurchReq."Document Type";
                        ApprovalEntry."Prepared By" := PurchReq."Prepared by";
                        ApprovalEntry."Currency Code" := PurchReq."Currency Code";
                        ApprovalEntry.Amount := PurchReq."Total Cost";
                        ApprovalEntry."Payee No." := PurchReq."Request-By No.";
                        ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
                        ApprovalEntry.Description := PurchReq."Posting Description";
                        ApprovalEntry."Posting Date" := PurchReq."Posting Date";
                        ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
                        ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until PurchReq.Next() = 0;
        Message('Done Now');
    end;

    procedure UpdateApprovalEntryInfoSTRQ()
    var
        PurchReq: Record "ADT Requisition Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        PurchReq.Reset();
        PurchReq.SetRange(PurchReq."Document Type", PurchReq."Document Type"::"Store Requisition");
        PurchReq.SetRange(PurchReq.Status, PurchReq.Status::"Pending Approval");
        if PurchReq.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchReq."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := PurchReq."Document Type";
                        ApprovalEntry."Prepared By" := PurchReq."Prepared by";
                        ApprovalEntry."Currency Code" := PurchReq."Currency Code";
                        ApprovalEntry."Payee No." := PurchReq."Request-By No.";
                        ApprovalEntry."Payee Name" := PurchReq."Request-By Name";
                        ApprovalEntry.Description := PurchReq."Posting Description";
                        ApprovalEntry."Posting Date" := PurchReq."Posting Date";
                        ApprovalEntry."Shortcut Dimension 1 Code" := PurchReq."Shortcut Dimension 1 Code";
                        ApprovalEntry."Shortcut Dimension 2 Code" := PurchReq."Shortcut Dimension 2 Code";
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until PurchReq.Next() = 0;
        Message('Done Now');
    end;

    procedure OpenApprovalEntriesPRQ(Rec: Record "ADT Requisition Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        SequenceNo: Integer;
    begin
        SequenceNo := 0;
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
        if ApprovalEntries.FindFirst() then begin
            SequenceNo := ApprovalEntries."Sequence No." + 1;
            ApprovalEntries1.Reset();
            ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
            ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
            ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
            ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
            if ApprovalEntries1.FindFirst() then begin
                ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
                ApprovalEntries1.Modify();
            end;
        end;
    end;

    procedure RejectApprovalRequestPRQ(Rec: Record "ADT Requisition Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        NvText: Label 'The approval Request has been rejected';
    begin

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Table ID", Database::"ADT Requisition Header");
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        //ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open, ApprovalEntries.Status::Created);
            if ApprovalEntries.FindSet() then begin
                repeat
                    ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
                    ApprovalEntries.Modify();
                until ApprovalEntries.Next() = 0;
            end;

        Rec.Status := Rec.Status::Rejected;
        Rec.Modify();
        // ApprovalEntries.Reset();
        // ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        // ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        // ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
        // if ApprovalEntries.FindFirst() then begin
        //     ApprovalEntries1.Reset();
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
        //     if ApprovalEntries1.FindFirst() then begin
        //         repeat
        //             ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
        //             ApprovalEntries1.Modify();
        //         until ApprovalEntries1.Next() = 0;
        //     end;
        //     OpenDocumentPRQ(Rec);
        //     Message(NvText);
        // end;
    end;

    procedure OpenDocumentPRQ(Rec: Record "ADT Requisition Header")
    var
        NFLRequisitionHeader: Record "ADT Requisition Header";
    begin
        NFLRequisitionHeader.Reset();
        NFLRequisitionHeader.SetRange(NFLRequisitionHeader."No.", Rec."No.");
        NFLRequisitionHeader.SetRange(NFLRequisitionHeader.Status, NFLRequisitionHeader.Status::"Pending Approval");
        if NFLRequisitionHeader.FindFirst() then begin
            NFLRequisitionHeader.Status := NFLRequisitionHeader.Status::Open;
            NFLRequisitionHeader.Modify();
        end;
    end;

    procedure DelegatePurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        Txt00003: Label 'Are you sure you want to delegate to:';
        MessageToSend: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            UserSetup.Reset();
            UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
            if UserSetup.FindFirst() then begin
                if UserSetup.Substitute <> '' then begin
                    MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
                    if Confirm(MessageToSend, true) then begin
                        ApprovalEntry."Approver ID" := UserSetup.Substitute;
                        ApprovalEntry."Last Modified By User ID" := UserId;
                        ApprovalEntry.Modify();
                        Message('Requisition has been Delegated to %1 Successfully', UserSetup.Substitute);
                    end;
                end else
                    Error('Substitute can not be empty. Contact your Systems Administrator');
            end else
                Error('You are not setup please consult your System Administrator');
        end else
            Error('You are not allowed to Delegate please contact your system Administrator');
    end;

    procedure escalateDocPRQ(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; NFLRequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        Txt0010: Label 'Are you sure you want to escalate to';
        SendMessage: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendMessage := Txt0010 + ' ' + EscalateTo;
            if Confirm(SendMessage, true) then begin
                ApprovalEntry."Approver ID" := EscalateTo;
                ApprovalEntry."Escalated By" := userIDEsc;
                ApprovalEntry."Escalated On" := Today();
                ApprovalEntry.Modify();
                Message('Document has been Escalated to: %1', EscalateTo);
            end else
                Message('The Document has not been escalate');
        end;
    end;

    procedure CancelPurchaseApprovalRequestPRQ(RequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        PurchRequisitionHeader: Record "ADT Requisition Header";
    begin
        PurchRequisitionHeader.Reset();
        PurchRequisitionHeader.SetRange(PurchRequisitionHeader."No.", RequisitionHeader."No.");
        PurchRequisitionHeader.SetRange(PurchRequisitionHeader.Status, PurchRequisitionHeader.Status::"Pending Approval");
        if PurchRequisitionHeader.FindFirst() then begin
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
            ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then
                repeat
                    ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                    ApprovalEntry."Last Modified By User ID" := UserId;
                    ApprovalEntry.Modify();
                until ApprovalEntry.Next() = 0;
            PurchRequisitionHeader.Status := PurchRequisitionHeader.Status::Open;
            PurchRequisitionHeader.Modify();
        end;
        Message('The Request has been Cancelled');
    end;

    procedure ReopenApprovalEntriesPRQ(RequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
            exit;

        VoucherAdmin := false;
        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then
            VoucherAdmin := true;

        if VoucherAdmin then
            if RequisitionHeader.Status = RequisitionHeader.Status::Open then begin
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            end;
    end;

    procedure EscalateGeneralRequisition(var Requisition: Record "ADT Requisition Header")
    var
        ApprovalEntries: Record "Approval Entry";
        UserSetup: Record "User Setup";
        Text001: Text;
    begin
        Requisition.CalcFields("Current Approver");
        UserSetup.Reset();
        UserSetup.SetRange("User ID", Requisition."Current Approver");
        UserSetup.SetRange("SBU Head", true);
        if UserSetup.FindFirst() then begin
            UserSetup.TestField("Escalate to");
            Text001 := 'The Requisition will be escalated to ' + UserSetup."Escalate to" + ' do you want to continue?';
            if Confirm(Text001, true) then begin
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Approver ID", Requisition."Current Approver");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);
                ApprovalEntries.SetRange("Document No.", Requisition."No.");
                if ApprovalEntries.FindFirst() then begin
                    ApprovalEntries.Validate("Approver ID", UserSetup."Escalate to");
                    ApprovalEntries.Validate("Escalated By", UserId);
                    ApprovalEntries.Validate("Escalated On", Today());
                    ApprovalEntries.Modify();
                    Message('The Requisition has been escalated to %1', UserSetup."Escalate to");
                end;
            end;
        end else
            Error('No User Setup record found for user: %1', Requisition."Current Approver");
    end;

    //===============Approval workflow mgt for Maintenance Request================

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageIDMR(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageIDMR(RecordRef);
    end;

    local procedure GetConditionalCardPageIDMR(RecordRef: RecordRef): Integer
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        RecordRef.SetTable(MaintenanceHeader);
        case MaintenanceHeader."Document Type" of
            MaintenanceHeader."Document Type"::"Maintenance Request":
                exit(PAGE::"Maintenance Request");
            MaintenanceHeader."Document Type"::"Job Card":
                exit(PAGE::"Maintenance Job Card");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocumentMR(RecRef: RecordRef; var Handled: Boolean)
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        case RecRef.Number of
            Database::"Maintenance Header":
                begin
                    RecRef.SetTable(MaintenanceHeader);
                    MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
                    MaintenanceHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocumentMR(RecRef: RecordRef; var Handled: Boolean)
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        case RecRef.Number of
            Database::"Maintenance Header":
                begin
                    RecRef.SetTable(MaintenanceHeader);
                    MaintenanceHeader.Status := MaintenanceHeader.Status::Released;
                    MaintenanceHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApprovalMR(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        case RecRef.Number of
            Database::"Maintenance Header":
                begin
                    RecRef.SetTable(MaintenanceHeader);
                    MaintenanceHeader.Status := MaintenanceHeader.Status::"Pending approval";
                    MaintenanceHeader.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibraryMR(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit 1521;
        WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeMR);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeMR);
        end;
    end;

    procedure CheckClaimApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
    begin
        if not IsClaimDocApprovalsWorkflowEnableMR(MaintenanceHeader) then
            Error(NoWorkflowEnabledErrMR);
        exit(true);
    end;

    procedure IsClaimDocApprovalsWorkflowEnableMR(var MaintenanceHeader: Record "Maintenance Header"): Boolean
    begin
        if MaintenanceHeader.Status <> MaintenanceHeader.Status::Open then
            exit(false);
        exit(WorkflowManagementMR.CanExecuteWorkflow(MaintenanceHeader, WorkflowEventHandlingCustMR.RunWorkflowOnSendClaimForApprovalCodeMR));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgumentMR(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        case RecRef.Number of
            Database::"Maintenance Header":
                begin
                    RecRef.SetTable(MaintenanceHeader);
                    ApprovalEntryArgument."Document No." := MaintenanceHeader."No.";
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelClaimForApprovalMR(var MaintenanceHeader: Record "Maintenance Header")
    begin
    end;

    procedure ReOpenLoanAdvanceMR(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        MaintenanceHeader: Record "Maintenance Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenLoanAdvanceMR(Variant);
                end;
            DATABASE::"Maintenance Header":
                begin
                    RecRef.SetTable(MaintenanceHeader);
                    MaintenanceHeader.Validate(Status, MaintenanceHeader.Status::Open);
                    MaintenanceHeader.Modify();
                    Variant := MaintenanceHeader;
                end;
        end;
    end;

    procedure modifyApprovalEntryMR(MaintenanceHeader: Record "Maintenance Header")
    var
        AmountLcy: Decimal;
        ApprovalEntry: Record "Approval Entry";
    begin
        AmountLcy := 0;
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindFirst() then
            repeat
                if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Maintenance Request" then begin
                    ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
                    ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
                    ApprovalEntry.Amount := 0;
                    ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
                    ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
                    ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
                    ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
                end else if MaintenanceHeader."Document Type" = MaintenanceHeader."Document Type"::"Job Card" then begin
                    ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
                    ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
                    ApprovalEntry.Amount := 0;
                    ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
                    ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
                    ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
                    ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
                end;
                ApprovalEntry.Modify();
            until ApprovalEntry.Next() = 0;
    end;

    procedure UpdateApprovalEntryInfoMR()
    var
        MaintenanceHeader: Record "Maintenance Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        MaintenanceHeader.Reset();
        MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Maintenance Request");
        MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
        if MaintenanceHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
                        ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
                        ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
                        ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
                        ApprovalEntry.Amount := 0;
                        ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
                        ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until MaintenanceHeader.Next() = 0;

        MaintenanceHeader.Reset();
        MaintenanceHeader.SetRange(MaintenanceHeader."Document Type", MaintenanceHeader."Document Type"::"Job Card");
        MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
        if MaintenanceHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := MaintenanceHeader."Document Type";
                        ApprovalEntry."Prepared By" := MaintenanceHeader."Prepared by";
                        ApprovalEntry.Amount := 0;
                        ApprovalEntry."Payee No." := MaintenanceHeader."Requester No.";
                        ApprovalEntry."Payee Name" := MaintenanceHeader."Requester Name";
                        ApprovalEntry.Description := PadStr(MaintenanceHeader."Request Summary", 240);
                        ApprovalEntry."Posting Date" := MaintenanceHeader."Posting Date";
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until MaintenanceHeader.Next() = 0;
    end;

    procedure OpenApprovalEntriesMR(Rec: Record "Maintenance Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        SequenceNo: Integer;
    begin
        SequenceNo := 0;
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
        if ApprovalEntries.FindFirst() then begin
            SequenceNo := ApprovalEntries."Sequence No." + 1;
            ApprovalEntries1.Reset();
            ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
            ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
            ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
            ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
            if ApprovalEntries1.FindFirst() then begin
                ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
                ApprovalEntries1.Modify();
            end;
        end;
    end;

    procedure RejectApprovalRequestMR(Rec: Record "Maintenance Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        NvText: Label 'The approval Request has been rejected';
    begin
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Table ID", Database::"Maintenance Header");
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        //ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open, ApprovalEntries.Status::Created);
            if ApprovalEntries.FindSet() then begin
                repeat
                    ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
                    ApprovalEntries.Modify();
                until ApprovalEntries.Next() = 0;
            end;

        Rec.Status := Rec.Status::Rejected;
        Rec.Modify();
        // ApprovalEntries.Reset();
        // ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        // ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        // ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
        // if ApprovalEntries.FindFirst() then begin
        //     ApprovalEntries1.Reset();
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
        //     if ApprovalEntries1.FindFirst() then
        //         repeat
        //             ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;
        //             ApprovalEntries1.Modify();
        //         until ApprovalEntries1.Next() = 0;
        //     OpenDocumentMR(Rec);
        //     Message(NvText);
        // end;
    end;

    procedure RejectApprovalRequestCP(Rec: Record "Cash Purchase")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        NvText: Label 'The approval Request has been rejected';
    begin
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Table ID", Database::"Cash Purchase");
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        //ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open, ApprovalEntries.Status::Created);
            if ApprovalEntries.FindSet() then begin
                repeat
                    ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
                    ApprovalEntries.Modify();
                until ApprovalEntries.Next() = 0;
            end;
             
        Rec.Status := Rec.Status::Rejected;
        Rec.Modify();
       
    end;

    procedure OpenDocumentMR(Rec: Record "Maintenance Header")
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        MaintenanceHeader.Reset();
        MaintenanceHeader.SetRange(MaintenanceHeader."No.", Rec."No.");
        MaintenanceHeader.SetRange(MaintenanceHeader.Status, MaintenanceHeader.Status::"Pending Approval");
        if MaintenanceHeader.FindFirst() then begin
            MaintenanceHeader.Status := MaintenanceHeader.Status::Open;
            MaintenanceHeader.Modify();
        end;
    end;

    procedure DelegatePurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        Txt00003: Label 'Are you sure you want to delegate to:';
        MessageToSend: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            UserSetup.Reset();
            UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
            if UserSetup.FindFirst() then begin
                if UserSetup.Substitute <> '' then begin
                    MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
                    if Confirm(MessageToSend, true) then begin
                        ApprovalEntry."Approver ID" := UserSetup.Substitute;
                        ApprovalEntry."Last Modified By User ID" := UserId;
                        ApprovalEntry.Modify();
                        Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
                    end;
                end else
                    Error('Substitute can not be empty. Contact your Systems Administrator');
            end else
                Error('You are not setup please consult your System Administrator');
        end else
            Error('You are not allowed to Delegate please contact your system Administrator');
    end;

    procedure escalateDocMR(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; MaintenanceHeader: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        Txt0010: Label 'Are you sure you want to escalate to';
        SendMessage: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendMessage := Txt0010 + ' ' + EscalateTo;
            if Confirm(SendMessage, true) then begin
                ApprovalEntry."Approver ID" := EscalateTo;
                ApprovalEntry."Escalated By" := userIDEsc;
                ApprovalEntry."Escalated On" := Today();
                ApprovalEntry.Modify();
                Message('Document has been Escalated to: %1', EscalateTo);
            end else
                Message('The Document has not been escalate');
        end;
    end;

    procedure CancelPurchaseApprovalRequestMR(MaintenanceHeader: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        RequisitionHeader: Record "Maintenance Header";
    begin
        RequisitionHeader.Reset();
        RequisitionHeader.SetRange(RequisitionHeader."No.", MaintenanceHeader."No.");
        RequisitionHeader.SetRange(RequisitionHeader.Status, RequisitionHeader.Status::"Pending Approval");
        if RequisitionHeader.FindFirst() then begin
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceHeader."No.");
            ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then
                repeat
                    ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                    ApprovalEntry."Last Modified By User ID" := UserId;
                    ApprovalEntry.Modify();
                until ApprovalEntry.Next() = 0;
            RequisitionHeader.Status := RequisitionHeader.Status::Open;
            RequisitionHeader.Modify();
        end;
        Message('The Request has been Cancelled');
    end;

    procedure ReopenApprovalEntriesMR(RequisitionHeader: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        if not (RequisitionHeader.Status = RequisitionHeader.Status::Open) then
            exit;

        VoucherAdmin := false;
        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then
            VoucherAdmin := true;

        if VoucherAdmin then
            if RequisitionHeader.Status = RequisitionHeader.Status::Open then begin
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", RequisitionHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            end;
    end;

    //===============Approval workflow mgt for Form Request================

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageIDFM(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageIDFM(RecordRef);
    end;

    local procedure GetConditionalCardPageIDFM(RecordRef: RecordRef): Integer
    var
        FormHeader: Record "Form Header";
        RequisitionHeader: Record "ADT Requisition Header";
        MaintenanceHeader: Record "Maintenance Header";
    begin
        if RecordRef.Number = Database::"Form Header" then begin
            RecordRef.SetTable(FormHeader);
            case FormHeader."Document Type" of
                FormHeader."Document Type"::"Equipment Hand Over":
                    exit(PAGE::"Equipment HandOver Form");
                FormHeader."Document Type"::"External Hire":
                    exit(Page::"External Hire Request");
                FormHeader."Document Type"::"Journey Management Plan":
                    exit(Page::"Journey Management Plan");
                    FormHeader."Document Type"::"Incident Notification Form":
                    exit(Page::"Incident Form");
            end;
        end;
        if RecordRef.Number = Database::"ADT Requisition Header" then begin
            RecordRef.SetTable(RequisitionHeader);
            case RequisitionHeader."Document Type" of
                RequisitionHeader."Document Type"::"Purchase Requisition":
                    if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then
                        exit(PAGE::"Spare Part Requisition");
                RequisitionHeader."Document Type"::"Store Requisition":
                    if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then
                        exit(PAGE::"Fuel Requisition");
            end;
        end;
        if RecordRef.Number = Database::"Maintenance Header" then begin
            RecordRef.SetTable(MaintenanceHeader);
            case MaintenanceHeader."Document Type" of
                MaintenanceHeader."Document Type"::"Maintenance Request":
                    exit(PAGE::"Maintenance Request");
                MaintenanceHeader."Document Type"::"Job Card":
                    exit(PAGE::"Maintenance Job Card");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocumentFM(RecRef: RecordRef; var Handled: Boolean)
    var
        FormHeader: Record "Form Header";
    begin
        case RecRef.Number of
            Database::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Status := FormHeader.Status::Open;
                    FormHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocumentFM(RecRef: RecordRef; var Handled: Boolean)
    var
        FormHeader: Record "Form Header";
        Cash : Record "Cash Purchase";
    begin
        case RecRef.Number of
            Database::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Status := FormHeader.Status::Released;
                    FormHeader.Modify();
                    Handled := true;
                end;
                 Database::"Cash Purchase":
                begin
                    RecRef.SetTable(Cash);
                    Cash.Status := FormHeader.Status::Released;
                    Cash.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApprovalFM(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FormHeader: Record "Form Header";
    begin
        case RecRef.Number of
            Database::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Status := FormHeader.Status::"Pending approval";
                    FormHeader.Modify();
                    IsHandled := true;
                end;
        end;
    end;
    
    //recently added
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    local procedure OnSetStatusToRejectedApprovalFM()
    var
        FormHeader: Record "Form Header";
    begin
        case RecRef.Number of
            Database::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Status := FormHeader.Status::"Rejected";
                    FormHeader.Modify();
                    //IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibraryFM(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit 1521;
        WorkflowEventHandlingCust: Codeunit "Workflow EventHandling Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEventHandlingCust.RunWorkflowOnSendClaimForApprovalCodeFM);
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEventHandlingCust.RunWorkflowOnCancelClaimApprovalCodeFM);
            //recently added
            // WorkflowResponseHandling.RejectAllApprovalRequestsCode:
            //     WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.RejectAllApprovalRequestsCode,
            //         WorkflowEventHandlingCust.Run);
        end;
    end;

    procedure CheckClaimApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
    begin
        if not IsClaimDocApprovalsWorkflowEnableFM(FormHeader) then
            Error(NoWorkflowEnabledErrFM);
        exit(true);
    end;

    procedure IsClaimDocApprovalsWorkflowEnableFM(var FormHeader: Record "Form Header"): Boolean
    begin
        if FormHeader.Status <> FormHeader.Status::Open then
            exit(false);
        exit(WorkflowManagementFM.CanExecuteWorkflow(FormHeader, WorkflowEventHandlingCustFM.RunWorkflowOnSendClaimForApprovalCodeFM));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgumentFM(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        FormHeader: Record "Form Header";
    begin
        if RecRef.Number <> Database::"Form Header" then
        exit;
        //recently added
        //RecRef.SetTable(FormHeader);
        ApprovalEntryArgument.INIT;
        ApprovalEntryArgument."Table ID" := RecRef.Number;
        ApprovalEntryArgument."Record ID to Approve":=RecRef.RECORDID;
        //ApprovalEntryArgument."Document Type":=ApprovalEntryArgument."Document Type"::" ";
        RecRef.SetTable(FormHeader);
        //older
        ApprovalEntryArgument."Document No." := FormHeader."No.";
        ApprovalEntryArgument."Document Type" := FormHeader."Document Type";
        ApprovalEntryArgument."Prepared By" := FormHeader."Prepared by";
        ApprovalEntryArgument."Posting Date" := FormHeader.Date;
        //original
        // case RecRef.Number of
        //     Database::"Form Header":
        //         begin
        //             RecRef.SetTable(FormHeader);
        //             ApprovalEntryArgument."Document No." := FormHeader."No.";
        //         end;
        // end;
    end;



    [IntegrationEvent(false, false)]
    procedure OnSendClaimForApprovalFM(var FormHeader: Record "Form Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelClaimForApprovalFM(var FormHeader: Record "Form Header")
    begin
    end;

    procedure ReOpenLoanAdvanceFM(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        FormHeader: Record "Form Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenLoanAdvanceFM(Variant);
                end;
            DATABASE::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Validate(Status, FormHeader.Status::Open);
                    FormHeader.Modify();
                    Variant := FormHeader;
                end;
        end;
    end;

    procedure modifyApprovalEntryFM(FormHeader: Record "Form Header")
    var
        AmountLcy: Decimal;
        ApprovalEntry: Record "Approval Entry";
    begin
        AmountLcy := 0;
        ApprovalEntry."Document No." := FormHeader."No.";
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
        ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
        if ApprovalEntry.FindFirst() then
            repeat
                ApprovalEntry."Document No." := FormHeader."No.";
                ApprovalEntry."Document Type" := FormHeader."Document Type";
                ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                ApprovalEntry."Posting Date" := FormHeader.Date;
                ApprovalEntry.Modify();

                //Original

                // if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Hand Over" then begin
                //     ApprovalEntry."Document Type" := FormHeader."Document Type";
                //     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                //     ApprovalEntry.Amount := 0;
                //     ApprovalEntry."Posting Date" := FormHeader.Date;
                // end else if FormHeader."Document Type" = FormHeader."Document Type"::"Equipment Inspection" then begin
                //     ApprovalEntry."Document Type" := FormHeader."Document Type";
                //     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                //     ApprovalEntry.Amount := 0;
                //     ApprovalEntry."Posting Date" := FormHeader.Date;
                // end else if FormHeader."Document Type" = FormHeader."Document Type"::"External Hire" then begin
                //     ApprovalEntry."Document Type" := FormHeader."Document Type";
                //     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                //     ApprovalEntry.Amount := 0;
                //     ApprovalEntry."Posting Date" := FormHeader.Date;
                // end else if FormHeader."Document Type" = FormHeader."Document Type"::"Journey Management Plan" then begin
                //     ApprovalEntry."Document Type" := FormHeader."Document Type";
                //     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                //     ApprovalEntry.Amount := 0;
                //     ApprovalEntry."Posting Date" := FormHeader.Date;
                // //Incident form
                // end else if FormHeader."Document Type" = FormHeader."Document Type"::"Incident Notification Form" then begin
                //     ApprovalEntry."Document Type" := FormHeader."Document Type";
                //     ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                //     ApprovalEntry.Amount := 0;
                //     ApprovalEntry."Posting Date" := FormHeader.Date;
                // end;
                // ApprovalEntry.Modify();
            until ApprovalEntry.Next() = 0;
    end;

    procedure UpdateApprovalEntryInfoFM()
    var
        FormHeader: Record "Form Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Hand Over");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := FormHeader."Document Type";
                        ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                        ApprovalEntry."Posting Date" := FormHeader.Date;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until FormHeader.Next() = 0;

        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Equipment Inspection");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := FormHeader."Document Type";
                        ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                        ApprovalEntry.Amount := 0;
                        ApprovalEntry."Posting Date" := FormHeader.Date;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until FormHeader.Next() = 0;

        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"External Hire");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := FormHeader."Document Type";
                        ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                        ApprovalEntry.Amount := 0;
                        ApprovalEntry."Posting Date" := FormHeader.Date;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until FormHeader.Next() = 0;

        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Journey Management Plan");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := FormHeader."Document Type";
                        ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                        ApprovalEntry.Amount := 0;
                        ApprovalEntry."Posting Date" := FormHeader.Date;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until FormHeader.Next() = 0;

        //Add incident form

        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."Document Type", FormHeader."Document Type"::"Incident Notification Form");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then
            repeat
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry."Document Type" := FormHeader."Document Type";
                        ApprovalEntry."Prepared By" := FormHeader."Prepared by";
                        ApprovalEntry."Posting Date" := FormHeader.Date;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            until FormHeader.Next() = 0;
    end;

    procedure OpenApprovalEntriesFM(Rec: Record "Form Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        SequenceNo: Integer;
    begin
        SequenceNo := 0;
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
        if ApprovalEntries.FindFirst() then begin
            SequenceNo := ApprovalEntries."Sequence No." + 1;
            ApprovalEntries1.Reset();
            ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", Rec."No.");
            ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
            ApprovalEntries1.SetRange(ApprovalEntries1."Sequence No.", SequenceNo);
            ApprovalEntries1.SetRange(ApprovalEntries1.Status, ApprovalEntries1.Status::Created);
            if ApprovalEntries1.FindFirst() then begin
                ApprovalEntries1.Status := ApprovalEntries1.Status::Open;
                ApprovalEntries1.Modify();
            end;
        end;
    end;

    procedure RejectApprovalRequestFM(Rec: Record "Form Header")
    var
        ApprovalEntries: Record "Approval Entry";
        ApprovalEntries1: Record "Approval Entry";
        NvText: Label 'The approval Request has been rejected';
    begin
        
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Table ID", Database::"Form Header");
        ApprovalEntries.SetRange(ApprovalEntries."Document No.", Rec."No.");
        //ApprovalEntries.SetRange(ApprovalEntries."Approver ID", UserId);
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open, ApprovalEntries.Status::Created);
            if ApprovalEntries.FindSet() then begin
                repeat
                    ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
                    ApprovalEntries.Modify();
                until ApprovalEntries.Next() = 0;
            end;
        
        Rec.Status := Rec.Status::Rejected;
        Rec.Modify();
        //ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Rejected);
        // if ApprovalEntries.FindFirst() then begin
        //     //will work
        //     ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
        //     ApprovalEntries.Reset();
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Document No.", ApprovalEntries."Document No.");
        //     ApprovalEntries1.SetRange(ApprovalEntries1."Approval Code", ApprovalEntries."Approval Code");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1."Approver ID", '<>%1', ApprovalEntries."Approver ID");
        //     ApprovalEntries1.SetFilter(ApprovalEntries1.Status, '%1|%2|%3', ApprovalEntries1.Status::Created, ApprovalEntries1.Status::Open, ApprovalEntries1.Status::Approved);
        //     if ApprovalEntries1.FindFirst() then
        //         repeat
        //             ApprovalEntries1.Status := ApprovalEntries1.Status::Rejected;  
        //             ApprovalEntries1.Modify();
        //         until ApprovalEntries1.Next() = 0;
        //     OpenDocumentFM(Rec);
        //     Message(NvText);
        // end;
    end;

    procedure SetStatusToRejected(Rec: Record "Form Header")
    var
        // SalesHeader: Record "Sales Header";
        // PurchaseHeader: Record "Purchase Header";
        // IncomingDocument: Record "Incoming Document";
        FormHeader: Record "Form Header";
        RecRef: RecordRef;
        IsHandled: Boolean;
    begin
        OnBeforeSetStatusToRejected(Rec);
        RecRef.GetTable(Rec);

        case RecRef.Number of
            // DATABASE::"Purchase Header":
            //     begin
            //         RecRef.SetTable(PurchaseHeader);
            //         PurchaseHeader.Validate(Status, PurchaseHeader.Status::"Pending Approval");
            //         PurchaseHeader.Modify(true);
            //         Variant := PurchaseHeader;
            //     end;
            // DATABASE::"Sales Header":
            //     begin
            //         RecRef.SetTable(SalesHeader);
            //         SalesHeader.Validate(Status, SalesHeader.Status::"Pending Approval");
            //         SalesHeader.Modify(true);
            //         Variant := SalesHeader;
            //     end;
            // DATABASE::"Incoming Document":
            //     begin
            //         RecRef.SetTable(IncomingDocument);
            //         IncomingDocument.Validate(Status, IncomingDocument.Status::"Pending Approval");
            //         IncomingDocument.Modify(true);
            //         Variant := IncomingDocument;
            //     end;
            DATABASE::"Form Header":
                begin
                    RecRef.SetTable(FormHeader);
                    FormHeader.Validate(Status, FormHeader.Status::"Rejected");
                    FormHeader.Modify(true);
                    Rec := FormHeader;
                end;
            else begin
                IsHandled := false;
                //OnSetStatusToRejected(RecRef, Variant, IsHandled);
                if not IsHandled then
                    Error(UnsupportedRecordTypeErr, RecRef.Caption);
            end;
        end;
    end;

    // procedure RejectRecordApprovalRequest(RecordID: RecordID)
    // var
    //     ApprovalEntry: Record "Approval Entry";
    // begin
    //     if not FindOpenApprovalEntryForCurrUser(ApprovalEntry, RecordID) then
    //         Error(NoReqToRejectErr);

    //     ApprovalEntry.SetRecFilter();
    //     RejectApprovalRequests(ApprovalEntry);
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetStatusToRejected(Rec: Record "Form Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetStatusToRejected(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    begin
    end;

    

    procedure OpenDocumentFM(Rec: Record "Form Header")
    var
        FormHeader: Record "Form Header";
    begin
        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."No.", Rec."No.");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then begin
            FormHeader.Status := FormHeader.Status::Open;
            FormHeader.Modify();
        end;
    end;

    procedure DelegatePurchaseApprovalRequestFM(FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        Txt00003: Label 'Are you sure you want to delegate to:';
        MessageToSend: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            UserSetup.Reset();
            UserSetup.SetRange(UserSetup."User ID", ApprovalEntry."Approver ID");
            if UserSetup.FindFirst() then begin
                if UserSetup.Substitute <> '' then begin
                    MessageToSend := Txt00003 + ' ' + UserSetup.Substitute;
                    if Confirm(MessageToSend, true) then begin
                        ApprovalEntry."Approver ID" := UserSetup.Substitute;
                        ApprovalEntry."Last Modified By User ID" := UserId;
                        ApprovalEntry.Modify();
                        Message('Request has been Delegated to %1 Successfully', UserSetup.Substitute);
                    end;
                end else
                    Error('Substitute can not be empty. Contact your Systems Administrator');
            end else
                Error('You are not setup please consult your System Administrator');
        end else
            Error('You are not allowed to Delegate please contact your system Administrator');
    end;

    procedure escalateDocFM(var ApproveCode: Code[50]; DocNo: Code[50]; userIDEsc: Code[50]; EscalateTo: Code[50]; FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        Txt0010: Label 'Are you sure you want to escalate to';
        SendMessage: Text[100];
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocNo);
        ApprovalEntry.SetRange(ApprovalEntry."Approval Code", ApproveCode);
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", userIDEsc);
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendMessage := Txt0010 + ' ' + EscalateTo;
            if Confirm(SendMessage, true) then begin
                ApprovalEntry."Approver ID" := EscalateTo;
                ApprovalEntry."Escalated By" := userIDEsc;
                ApprovalEntry."Escalated On" := Today();
                ApprovalEntry.Modify();
                Message('Document has been Escalated to: %1', EscalateTo);
            end else
                Message('The Document has not been escalate');
        end;
    end;

    procedure CancelPurchaseApprovalRequestFM(FormHeader1: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        FormHeader: Record "Form Header";
    begin
        FormHeader.Reset();
        FormHeader.SetRange(FormHeader."No.", FormHeader1."No.");
        FormHeader.SetRange(FormHeader.Status, FormHeader.Status::"Pending Approval");
        if FormHeader.FindFirst() then begin
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader1."No.");
            ApprovalEntry.SetFilter(ApprovalEntry.Status, '%1|%2|%3', ApprovalEntry.Status::Approved, ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then
                repeat
                    ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                    ApprovalEntry."Last Modified By User ID" := UserId;
                    ApprovalEntry.Modify();
                until ApprovalEntry.Next() = 0;
            FormHeader.Status := FormHeader.Status::Open;
            FormHeader.Modify();
        end;
        Message('The Request has been Cancelled');
    end;

    procedure ReopenApprovalEntriesFM(FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        if not (FormHeader.Status = FormHeader.Status::Open ) then
            exit;

        VoucherAdmin := false;
        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then
            VoucherAdmin := true;

        if VoucherAdmin then
            if FormHeader.Status = FormHeader.Status::Open then begin
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                //recently
                //ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::"");
                if ApprovalEntry.FindFirst() then
                    repeat
                        ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                        ApprovalEntry.Modify();
                    until ApprovalEntry.Next() = 0;
            end;
    end;

    //===============End Approval workflow mgt for Form Request================

    //Attachments =============

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDownDocMR(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ADTRequisition: Record "Maintenance Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Maintenance Header":
                begin
                    RecRef.Open(Database::"Maintenance Header");
                    ADTRequisition.Reset();
                    ADTRequisition.SetRange("No.", DocumentAttachment."No.");
                    if ADTRequisition.FindFirst() then
                        RecRef.GetTable(ADTRequisition);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRefDocMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FRef: FieldRef;
        RecNo: Code[50];
    begin
        case RecRef.Number of
            Database::"Maintenance Header":
                begin
                    FRef := RecRef.Field(1);
                    RecNo := FRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRefMR(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[50];
    begin
        if RecRef.Number = Database::"Maintenance Header" then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value();
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDownDocFM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ADTRequisition: Record "Form Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Form Header":
                begin
                    RecRef.Open(Database::"Form Header");
                    ADTRequisition.Reset();
                    ADTRequisition.SetRange("No.", DocumentAttachment."No.");
                    if ADTRequisition.FindFirst() then
                        RecRef.GetTable(ADTRequisition);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRefDocFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FRef: FieldRef;
        RecNo: Code[50];
    begin
        case RecRef.Number of
            Database::"Form Header":
                begin
                    FRef := RecRef.Field(1);
                    RecNo := FRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRefPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[50];
    begin
        if RecRef.Number = Database::"Form Header" then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value();
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDownDocPM(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        PerformanceHeader: Record "Performance Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Performance Header":
                begin
                    RecRef.Open(Database::"Performance Header");
                    PerformanceHeader.Reset();
                    PerformanceHeader.SetRange("No.", DocumentAttachment."No.");
                    if PerformanceHeader.FindFirst() then
                        RecRef.GetTable(PerformanceHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRefDocPM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FRef: FieldRef;
        RecNo: Code[50];
    begin
        case RecRef.Number of
            Database::"Performance Header":
                begin
                    FRef := RecRef.Field(1);
                    RecNo := FRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRefFM(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[50];
    begin
        if RecRef.Number = Database::"Performance Header" then begin
            FieldRef := RecRef.Field(1);
            RecNo := FieldRef.Value();
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDownDoc(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ADTRequisition: Record "ADT Requisition Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"ADT Requisition Header":
                begin
                    RecRef.Open(Database::"ADT Requisition Header");
                    ADTRequisition.Reset();
                    ADTRequisition.SetRange("No.", DocumentAttachment."No.");
                    if ADTRequisition.FindFirst() then
                        RecRef.GetTable(ADTRequisition);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRefDoc(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FRef: FieldRef;
        RecNo: Code[50];
    begin
        case RecRef.Number of
            Database::"ADT Requisition Header":
                begin
                    FRef := RecRef.Field(3);
                    RecNo := FRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[50];
    begin
        if RecRef.Number = Database::"ADT Requisition Header" then begin
            FieldRef := RecRef.Field(3);
            RecNo := FieldRef.Value();
            DocumentAttachment.Validate("No.", RecNo);
        end;
    end;

    // Item Ledger / Value / Vendor Ledger entry updates

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    begin
        ItemLedgerEntry."Equipment No." := ItemJournalLine."Equipment No.";
        ItemLedgerEntry."Equipment Type" := ItemJournalLine."Equipment Type";
        ItemLedgerEntry."Store Req. No" := ItemJournalLine."Store Req. No";
        ItemLedgerEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
        ItemLedgerEntry."Employee No." := ItemJournalLine."Employee No.";
        ItemLedgerEntry."From Store Req" := ItemJournalLine."From Store Req";
        ItemLedgerEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
        ItemLedgerEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
    begin
        ValueEntry."Equipment No." := ItemJournalLine."Equipment No.";
        ValueEntry."Equipment Type" := ItemJournalLine."Equipment Type";
        ValueEntry."Store Req. No" := ItemJournalLine."Store Req. No";
        ValueEntry."Store Req. Invt Charge Acc" := ItemJournalLine."Store Req. Invt Charge Acc";
        ValueEntry."Employee No." := ItemJournalLine."Employee No.";
        ValueEntry."From Store Req" := ItemJournalLine."From Store Req";
        ValueEntry."Responsible Employee" := ItemJournalLine."Responsible Employee";
        ValueEntry."Purchase Requisition No." := ItemJournalLine."Purchase Requisition No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitVendLedgEntry', '', false, false)]
    local procedure OnBeforeInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Equipment No." := GenJournalLine."Equipment No.";
        VendorLedgerEntry."Equipment Type" := GenJournalLine."Equipment Type";
        VendorLedgerEntry."Responsible Employee" := GenJournalLine."Responsible Employee";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeUpdatePurchaseHeader', '', false, false)]
    local procedure OnBeforeUpdatePurchaseHeader(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; GenJnlLineDocType: Option; var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    begin
        VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
        VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
        VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
        VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeItemJnlPostLine, '', false, false)]
    local procedure OnBeforeItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; var IsHandled: Boolean; WhseReceiptHeader: Record "Warehouse Receipt Header"; WhseShipmentHeader: Record "Warehouse Shipment Header"; TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary; TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    begin
        ItemJournalLine."Equipment No." := PurchaseLine."Equipment No.";
        ItemJournalLine."Equipment Type" := PurchaseLine."Equipment Type";
        ItemJournalLine."Store Req. No" := PurchaseHeader."Purchase Requisition No.";
        ItemJournalLine."Responsible Employee" := PurchaseLine."Responsible Employee";
        ItemJournalLine."Purchase Requisition No." := PurchaseHeader."Purchase Requisition No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; EverythingInvoiced: Boolean)
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if not PreviewMode then
            if PurchHeader."Document Type" in [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::Order] then begin
                VendorLedgerEntry.Reset();
                VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
                if VendorLedgerEntry.FindFirst() then begin
                    VendorLedgerEntry."Equipment No." := PurchInvHeader."Equipment No.";
                    VendorLedgerEntry."Equipment Type" := PurchInvHeader."Equipment Type";
                    VendorLedgerEntry."Purchase Requisition No." := PurchInvHeader."Purchase Requisition No.";
                    VendorLedgerEntry."Responsible Employee" := PurchInvHeader."Responsible Employee";
                    VendorLedgerEntry.Modify();
                end;
            end;
    end;
    

}

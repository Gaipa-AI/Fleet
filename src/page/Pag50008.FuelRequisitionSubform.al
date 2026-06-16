page 50008 "Fuel Requisition Subform"
{
    AutoSplitKey = true;
    Caption = 'Comsumption Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "ADT Requisition Line";
    SourceTableView = WHERE("Document Type" = FILTER("Store Requisition"), "Request Type" = filter(Fuel));
    Permissions = tabledata "ADT Requisition Header" = rim,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rm;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = RequisitionOpen;

                    trigger OnValidate()
                    begin
                        Rec.Type := Rec.Type::Item;
                    end;
                }
                field("No."; Rec."No.")
                {
                    Editable = RequisitionOpen;
                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = RequisitionOpen;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = RequisitionOpen;
                }
                field("Available Quantity"; Rec."Available Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Quantity field.';
                }
                field("Avail Qty AtCurrentLocation"; Rec."Avail Qty AtCurrentLocation")
                {
                    ApplicationArea = All;
                }

                field("Qty. Requested"; Rec."Qty. Requested")
                {
                    Editable = RequisitionOpen;

                    trigger OnValidate();
                    var
                        lvADTheader: Record "ADT Requisition Header";
                        RequisitionLine: Record "ADT Requisition Line";
                        ItemJournalLine: Record "Item Journal Line";
                        JobJournalLine: Record "Job Journal Line";
                        RequisitionLineQty: Decimal;
                        ItemJournalLineQty: Decimal;
                        JobJournalLineQty: Decimal;
                        ApprovalEntry: Record "Approval Entry";
                    begin

                        RequisitionLineQty := 0;
                        ItemJournalLineQty := 0;
                        JobJournalLineQty := 0;

                        lvADTheader.GET(Rec."Document Type", Rec."Request Type", Rec."Document No.");

                        IF lvADTheader.Status = lvADTheader.Status::Released THEN ERROR('Status for the document must be open damn')
                        //recently added
                        else begin
                            if lvADTheader.Status = lvADTheader.Status::"Pending Approval" then begin
                                ApprovalEntry.RESET();
                                ApprovalEntry.SETRANGE("Table ID", DATABASE::"ADT Requisition Header");
                                ApprovalEntry.SETRANGE("Document Type", lvADTheader."Document Type");
                                ApprovalEntry.SETRANGE("Document No.", lvADTheader."No.");
                                ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
                                IF not ApprovalEntry.FINDFIRST THEN
                                    ERROR('Document is pending approval and can only be modified by the current approver');
                            end 
                            //else lvADTheader.TestField(Status, lvADTheader.Status::Open);
                            
                        end;

                        RequisitionLine.Reset();
                        RequisitionLine.SetRange("No.", Rec."No.");
                        RequisitionLine.SetRange("Location Code", Rec."Location Code");
                        RequisitionLine.SetRange("Document Type", Rec."Document Type"::"Store Requisition");
                        RequisitionLine.SetRange(Type, Rec.Type::Item);
                        RequisitionLine.SetFilter("Document No.", '<>%1', Rec."Document No.");
                        if RequisitionLine.FindFirst() then begin
                            repeat
                                RequisitionLineQty += RequisitionLine."Qty. Requested";
                            until RequisitionLine.Next() = 0;
                        end;

                        ItemJournalLine.Reset();
                        ItemJournalLine.SetRange("Item No.", Rec."No.");
                        ItemJournalLine.SetRange("Location Code", Rec."Location Code");
                        ItemJournalLine.SetRange("From Store Req", false);
                        if ItemJournalLine.FindFirst() then
                            repeat
                                ItemJournalLineQty += ItemJournalLine.Quantity;
                            until ItemJournalLine.Next() = 0;

                        if Rec."Qty. Requested" > Rec."Available Quantity" then
                            Error('Quantity Requested can not be greater than the available quantity.');

                        //calculate qty for jnl and qty for req
                        IF PurchInfoPaneMgt.CalcAvailability2(Rec) < (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req") THEN BEGIN
                            IF PurchInfoPaneMgt.CalcAvailability2(Rec) > 0 THEN BEGIN
                                Rec."Qty To Transfer to Item Jnl" := PurchInfoPaneMgt.CalcAvailability2(Rec);
                                Rec."Qty To Make Purch. Req." := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req")
                                                      - PurchInfoPaneMgt.CalcAvailability2(Rec);

                            END ELSE BEGIN
                                Rec."Qty To Transfer to Item Jnl" := 0;
                            END;
                            IF Rec.MODIFY THEN;
                        END ELSE BEGIN
                            Rec."Make Purchase Req." := FALSE;
                            Rec."Qty To Make Purch. Req." := 0;
                            Rec."Qty To Transfer to Item Jnl" := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req");
                            IF Rec.MODIFY THEN;
                        END;
                        
                        QtyRequestedOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = RequisitionOpen;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Transfer to Item Jnl"; Rec."Transfer to Item Jnl")
                {
                    Editable = RequisitionOpen;
                }
                field("Qty To Transfer to Item Jnl"; Rec."Qty To Transfer to Item Jnl")
                {
                    Editable = RequisitionOpen;
                    DecimalPlaces = 0 : 5;

                    trigger OnValidate();
                    begin
                        Rec."Qty To Make Purch. Req." := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req") - Rec."Qty To Transfer to Item Jnl";
                        IF Rec."Qty To Make Purch. Req." < 0 THEN ERROR('You are issuing more than is possible for this line');
                    end;
                }
                field("Req. Reserved Quantity"; Rec."Req. Reserved Quantity")
                {
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    Visible = false;
                }
                field("Transfer to Job Jnl"; Rec."Transfer to Job Jnl")
                {
                    Editable = RequisitionOpen;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer to Job Jnl field.';
                    Visible = false;
                }
                field("Qty To Transfer to Job Jnl"; Rec."Qty To Transfer to Job Jnl")
                {
                    Editable = RequisitionOpen;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty To Transfer to Job Jnl field.';
                    Visible = false;
                }
                field("Total Qty To Item Jnl"; Rec."Total Qty To Item Jnl")
                {
                    Caption = 'Total Issued To Item Jnl';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("Total Qty To Job Jnl"; Rec."Total Qty To Job Jnl")
                {
                    ApplicationArea = All;
                    Caption = 'Total Issued To Job Jnl';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Qty To Job Jnl field.';
                    Visible = false;
                }
                field(gvFA; gvFA)
                {
                    Caption = 'FA No.';
                    TableRelation = "Fixed Asset"."No.";
                    Visible = false;
                }
                field("Make Purchase Req."; Rec."Make Purchase Req.")
                {
                    Visible = false;
                }
                field("Qty To Make Purch. Req."; Rec."Qty To Make Purch. Req.")
                {
                    DecimalPlaces = 0 : 5;
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec."Qty To Transfer to Item Jnl" :=
                        (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req") - Rec."Qty To Make Purch. Req.";
                        IF Rec."Qty To Transfer to Item Jnl" < 0 THEN ERROR('You are ordering more than is possible for this line');
                    end;
                }
                field("Total Qty To Purch. Req"; Rec."Total Qty To Purch. Req")
                {
                    Visible = false;
                    Caption = 'Total Ordered';
                    DecimalPlaces = 0 : 5;
                }
                field("G/L Expense A/c"; Rec."G/L Expense A/c")
                {
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = false;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }

                field("Inventory Charge A/c"; Rec."Inventory Charge A/c")
                {
                    Visible = false;
                }
                field("Transferred To Item Jnl"; Rec."Transferred To Item Jnl")
                {
                    Visible = false;
                }
                field("Transferred To Purch. Req."; Rec."Transferred To Purch. Req.")
                {
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    // Editable = CanEditRequisition;
                    ToolTip = 'Specifies the value of the Job No. field.';
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    // Editable = CanEditRequisition;
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    // Editable = CanEditRequisition;
                    ToolTip = 'Specifies the value of the Job Line Type field.';
                    Visible = false;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = true;
                    Editable = RequisitionOpen;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = true;
                    Editable = RequisitionOpen;
                }
                field(Control300; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    Editable = RequisitionOpen;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(Control301; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    Visible = false;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(Control302; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    Visible = false;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(Control303; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    Visible = false;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(Control304; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    Visible = false;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(Control305; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    Visible = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Transferred To Item Jnl1"; Rec."Transferred To Item Jnl")
                {
                    Visible = true;
                    Editable = false;
                }
                field("Transferred to Job Jnl"; Rec."Transferred to Job Jnl")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transferred to Job Jnl field.';
                    Visible = false;
                }
            }
            group(ItemPanel)
            {
                Caption = 'Item Information';
                Visible = false;
                field(Cont0001; STRSUBSTNO('%1', PurchInfoPaneMgt.CalcAvailability2(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field(Cont0002; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field(Cont0003; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }
            // group(Totals)
            // {
            //     Caption = 'Totals';
            //     field(RunningQty; RunningQty)
            //     {
            //         Caption = 'Cum. Qty';
            //         Editable = false;
            //     }
            //     field(RunningAmt; RunningAmt)
            //     {
            //         Caption = 'Cum. Amt';
            //         Editable = false;
            //     }
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action("Item  Tracking Lines")
                {
                    Caption = 'Item  Tracking Lines';

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _OpenItemTrackingLines;

                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406294. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        //ShowReservationEntries;

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        RequisitionHeader: Record "ADT Requisition Header";
        UserSetup: Record "User Setup";
    begin
        RequisitionOpen := false;
        CanEditRequisition := false;
        FinalStatus := false;

        RequisitionHeader.Reset();
        RequisitionHeader.SetRange("No.", Rec."Document No.");
        RequisitionHeader.SetRange(Status, RequisitionHeader.Status::Open);
        if RequisitionHeader.FindFirst() then
            RequisitionOpen := true
        else
            RequisitionOpen := true;

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Requisition Admin" or UserSetup."Edit Requisition Line" then
                CanEditRequisition := true;
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            //AMI
            /*IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
              EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);  */
        END;

    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        PurchHeader: Record "Purchase Header";
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
        //CMM DEFAULTING LOCATION ON HEADER
        PurchHeader.SETRANGE("Document Type", Rec."Document Type");
        PurchHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchHeader.FINDFIRST THEN
            Rec."Location Code" := PurchHeader."Location Code";
        //END;
        OnAfterGetCurrRecord;
    end;

    var
        TransferExtendedText: Codeunit "Fleet Management";
        ShortcutDimCode: array[9] of Code[20];
        PurchInfoPaneMgt: Codeunit "Fleet Management";
        PurchHeader: Record "ADT Requisition Header";
        PurchPriceCalcMgt: Codeunit "Fleet Management";
        RunningQty: Decimal;
        RunningAmt: Decimal;
        gvFA: Code[20];
        RequisitionOpen: Boolean;
        CanEditRequisition: Boolean;
        FinalStatus: Boolean;

    /// <summary> 
    /// Description for ApproveCalcInvDisc.
    /// </summary>
    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    /// <summary> 
    /// Description for CalcInvDisc.
    /// </summary>
    procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    /// <summary> 
    /// Description for ExplodeBOM.
    /// </summary>
    procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    /// <summary> 
    /// Description for OpenSalesOrderForm.
    /// </summary>
    procedure OpenSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    /// <summary> 
    /// Description for _InsertExtendedText.
    /// </summary>
    /// <param name="Unconditionally">Parameter of type Boolean.</param>
    procedure _InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    /// <summary> 
    /// Description for InsertExtendedText.
    /// </summary>
    /// <param name="Unconditionally">Parameter of type Boolean.</param>
    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    /// <summary> 
    /// Description for _ShowReservation.
    /// </summary>
    procedure _ShowReservation();
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    /// <summary> 
    /// Description for ShowReservation.
    /// </summary>
    procedure ShowReservation();
    begin
        Rec.FIND;
        Rec.ShowReservation;
    end;

    /// <summary> 
    /// Description for _ItemAvailability.
    /// </summary>
    /// <param name="AvailabilityType">Parameter of type Option Date,Variant,Location,Bin.</param>
    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        Rec.ItemAvailability(AvailabilityType);
    end;

    /// <summary> 
    /// Description for ItemAvailability.
    /// </summary>
    /// <param name="AvailabilityType">Parameter of type Option Date,Variant,Location,Bin.</param>
    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        Rec.ItemAvailability(AvailabilityType);
    end;

    /// <summary> 
    /// Description for ShowReservationEntries.
    /// </summary>
    procedure ShowReservationEntries();
    begin
        Rec.ShowReqReservationEntries;
    end;

    /// <summary> 
    /// Description for ShowTracking.
    /// </summary>
    procedure ShowTracking();
    var
        TrackingForm: Page "Order Tracking";
    begin
        //AMI
        /*TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
        */

    end;

    /// <summary> 
    /// Description for _ShowDimensions.
    /// </summary>
    procedure _ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;

    /// <summary> 
    /// Description for ShowDimensions.
    /// </summary>
    procedure ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;

    /// <summary> 
    /// Description for ItemChargeAssgnt.
    /// </summary>
    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    /// <summary> 
    /// Description for _OpenItemTrackingLines.
    /// </summary>
    procedure _OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
    end;

    /// <summary> 
    /// Description for OpenItemTrackingLines.
    /// </summary>
    procedure OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
    end;

    /// <summary> 
    /// Description for OpenSpecOrderSalesOrderForm.
    /// </summary>
    procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    /// <summary> 
    /// Description for UpdateForm.
    /// </summary>
    /// <param name="SetSaveRecord">Parameter of type Boolean.</param>
    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    /// <summary> 
    /// Description for ShowPrices.
    /// </summary>
    procedure ShowPrices();
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    /// <summary> 
    /// Description for ShowLineDisc.
    /// </summary>
    procedure ShowLineDisc();
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    /// <summary> 
    /// Description for ShowLineComments.
    /// </summary>
    procedure ShowLineComments();
    begin
        Rec.ShowLineComments;
    end;

    /// <summary> 
    /// Description for ==CMM.
    /// </summary>
    procedure "==CMM=="();
    begin
    end;

    /// <summary> 
    /// Description for GetLineSumQty.
    /// </summary>
    /// <returns>Return variable "Decimal".</returns>
    procedure GetLineSumQty(): Decimal;
    begin
        EXIT(Rec.CalcRunningQty);
    end;

    /// <summary> 
    /// Description for GetLineSumAmt.
    /// </summary>
    /// <returns>Return variable "Decimal".</returns>
    procedure GetLineSumAmt(): Decimal;
    begin
        EXIT(Rec.CalcRunningAmt);
    end;

    /// <summary> 
    /// Description for NoOnAfterValidate.
    /// </summary>
    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;

        //cmm 040809 fill in the qty available as transferrable to item journal
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            Rec."Qty To Transfer to Item Jnl" := PurchInfoPaneMgt.CalcAvailability2(Rec);
            IF Rec."Qty To Transfer to Item Jnl" > 0 THEN
                Rec."Transfer to Item Jnl" := TRUE
            ELSE
                Rec."Transfer to Item Jnl" := FALSE;
        END;
        //MODIFY;
        //end cmm
    end;

    /// <summary> 
    /// Description for QtyRequestedOnAfterValidate.
    /// </summary>
    local procedure QtyRequestedOnAfterValidate();
    var
        // ReserveReqLine: Codeunit "Req-Line Reserve2";
        Item2: Record Item;
    begin
        // Message(Format(PurchInfoPaneMgt.CalcAvailability2(Rec)));
        IF PurchInfoPaneMgt.CalcAvailability2(Rec) < (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req") THEN BEGIN
            IF PurchInfoPaneMgt.CalcAvailability2(Rec) > 0 THEN BEGIN
                Rec."Qty To Transfer to Item Jnl" := PurchInfoPaneMgt.CalcAvailability2(Rec);
                Rec."Qty To Make Purch. Req." := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req")
                                      - PurchInfoPaneMgt.CalcAvailability2(Rec);

            END ELSE BEGIN
                Rec."Qty To Transfer to Item Jnl" := 0;
                Rec."Qty To Make Purch. Req." := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req");
            END;
            Rec."Make Purchase Req." := TRUE;
            IF Rec.MODIFY THEN;
        END ELSE BEGIN
            Rec."Make Purchase Req." := FALSE;
            Rec."Qty To Make Purch. Req." := 0;
            Rec."Qty To Transfer to Item Jnl" := (Rec."Qty. Requested" - Rec."Total Qty To Item Jnl" - Rec."Total Qty To Purch. Req");
            IF Rec.MODIFY THEN;
        END;
    end;

    /// <summary> 
    /// Description for OnAfterGetCurrRecord.
    /// </summary>
    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        //cmm 171109 show the running totals per line
        RunningQty := GetLineSumQty;
        RunningAmt := GetLineSumAmt;
    end;
}


page 50003 "Spare Part Requisition Subform"
{
    AutoSplitKey = true;
    Caption = 'Spare Parts Requisition Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "ADT Requisition Line";
    SourceTableView = WHERE("Document Type" = FILTER("Purchase Requisition"), "Request Type" = filter("Spare Parts"));
    Permissions = tabledata "ADT Requisition Header" = rm,
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
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                        CurrPage.UPDATE;
                    end;
                }
                field("Budget Code"; Rec."Budget Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Control Account"; Rec."Control Account")
                {
                    ApplicationArea = All;
                    Caption = 'Expense Account';
                    Visible = false;
                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate();
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Priority Ranking"; Rec."Priority Ranking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Priority Ranking field.', Comment = '%';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Currentstock;Rec.Currentstock)
                {
                    ApplicationArea = All;
                    Caption = 'Available Qty at Current Location';
                    //Editable = false;
                }
                field("Available Quantity"; Rec."Available Quantity")
                {
                    ApplicationArea = All;
                }
                // field("Avail Qty AtCurrentLocation"; Rec."Avail Qty AtCurrentLocation")
                // {
                //     ApplicationArea = All;
                // }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Transfer to Job Jnl"; Rec."Transfer to Job Jnl")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Transfer to Job Jnl field.';
                }
                field("Transferred to Job Jnl"; Rec."Transferred to Job Jnl")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Transferred to Job Jnl field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Direct Unit Cost (LCY)"; Rec."Direct Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Line Amount (LCY)"; Rec."Line Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Convert; Rec.Convert)
                {
                    ApplicationArea = All;
                    Editable = RecState;
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = All;
                    Caption = 'Converted To Order';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Order"; Rec."Qty. to Order")
                {
                    ApplicationArea = All;
                }
                field("Qty To Transfer to Job Jnl"; Rec."Qty To Transfer to Job Jnl")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty To Transfer to Job Jnl field.';
                    Visible = false;
                }
                field("Total Qty To Job Jnl"; Rec."Total Qty To Job Jnl")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Qty To Job Jnl field.';
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Job Line Type field.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. Requested"; Rec."Qty. Requested")
                {
                    ApplicationArea = All;
                }
                field("Transfer to Item Jnl"; Rec."Transfer to Item Jnl")
                {
                    ApplicationArea = All;
                    Caption = 'Consume from Inventory';
                }
                field("Qty To Transfer to Item Jnl"; Rec."Qty To Transfer to Item Jnl")
                {
                    ApplicationArea = All;
                    Caption = 'Qty to consume from Inventory';
                }
                field("Total Qty To Item Jnl"; Rec."Total Qty To Item Jnl")
                {
                    ApplicationArea = All;
                    //Caption = 'Total Issued to Journal';
                    Editable = false;
                    Caption = 'Total Qty consumed from Inventory';
                }
                field("Transferred To Item Jnl"; Rec."Transferred To Item Jnl")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Consumed from Inventory';
                }

                field(Transferred; Rec.Transfered)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = true;
                    Caption = 'Consumed';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Remarks;Rec.Remarks)
                {
                    ToolTip = 'Approvers remarks/comments';
                    ApplicationArea = All;
                  
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Control300; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    Visible = false;
                    CaptionClass = '1,2,3';
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
                    Visible = false;
                    Editable = false;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Budget Amount as at Date"; Rec."Budget Amount as at Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Actual Amount as at Date"; Rec."Actual Amount as at Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Budget Comment as at Date"; Rec."Budget Comment as at Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Budget Amount for the Year"; Rec."Budget Amount for the Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Actual Amount for the Year"; Rec."Actual Amount for the Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Budget Comment for the Year"; Rec."Budget Comment for the Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Budget Comment"; Rec."Budget Comment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Committed; Rec.Committed)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Exceeded at Date Budget"; Rec."Exceeded at Date Budget")
                {
                    ToolTip = 'Specifies the value of the Exceeded at Date Budget field';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Exceeded Month Budget"; Rec."Exceeded Month Budget")
                {
                    ToolTip = 'Specifies the value of the Exceeded Month Budget field';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Exceeded Quarter Budget"; Rec."Exceeded Quarter Budget")
                {
                    ToolTip = 'Specifies the value of the Exceeded Quarter Budget field';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Exceeded Year Budget"; Rec."Exceeded Year Budget")
                {
                    ToolTip = 'Specifies the value of the Exceeded Year Budget field';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(ItemPanel)
            {
                Caption = 'Item Information';
                Visible = false;
                field(Contr0002; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;
                }
                field(Contr0003; STRSUBSTNO('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Editable = false;
                }
            }
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

                        ApplicationArea = All;
                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';

                        ApplicationArea = All;
                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';

                        ApplicationArea = All;
                        trigger OnAction();
                        begin
                            //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowDimensions;

                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        ShowLineComments;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #51406300. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _InsertExtendedText(TRUE);

                    end;
                }
            }
            action("Purchase Line &Discounts")
            {
                Caption = 'Purchase Line &Discounts';
                ApplicationArea = All;
                trigger OnAction();
                begin
                    ShowLineDisc;
                    CurrPage.UPDATE;
                end;
            }
            action("Purcha&se Prices")
            {
                Caption = 'Purcha&se Prices';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ShowPrices;
                    CurrPage.UPDATE;
                end;
            }
            action("Availa&bility")
            {
                Caption = 'Availa&bility';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ItemAvailability(0);
                    CurrPage.UPDATE(TRUE);
                end;
            }
            action("Ite&m Card")
            {
                Caption = 'Ite&m Card';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    PurchInfoPaneMgt.LookupItem(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin

    end;

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Rec.SETFILTER("Fiscal Year Date Filter", '%1..%2', Rec."Fiscal Year Start Date", Rec."Fiscal Year End Date");
        Rec.SETFILTER("Filter to Date Filter", '%1..%2', Rec."Filter to Date Start Date", Rec."Fiscal Year End Date");
        Rec.SETFILTER("Month Date Filter", '%1..%2', Rec."Accounting Period Start Date", Rec."Accounting Period End Date");
        Rec.SETFILTER("Quarter Date Filter", '%1..%2', Rec."Quarter Start Date", Rec."Quarter End Date");

        IF Rec.Converted = TRUE THEN
            RecState := FALSE
        ELSE
            RecState := TRUE;
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        UpdateHeader(0);
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
        END;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        UpdateHeader(1);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        UpdateHeader(1);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage();
    begin
        Rec.SETFILTER("Fiscal Year Date Filter", '%..%2', Rec."Fiscal Year Start Date", Rec."Fiscal Year End Date");
        Rec.SETFILTER("Filter to Date Filter", '%1..%2', Rec."Filter to Date Start Date", Rec."Fiscal Year End Date");
        Rec.SETFILTER("Month Date Filter", '%1..%2', Rec."Accounting Period Start Date", Rec."Accounting Period End Date");
        Rec.SETFILTER("Quarter Date Filter", '%1..%2', Rec."Quarter Start Date", Rec."Quarter End Date");

    end;

    var
        TransferExtendedText: Codeunit "Fleet Management";
        ShortcutDimCode: array[9] of Code[20];
        PurchInfoPaneMgt: Codeunit "Fleet Management";
        "---MAG---": Integer;
        TotalPurchaseHeader: Record "ADT Requisition Header";
        TotalPurchaseLine: Record "ADT Requisition Line";
        PurchHeader: Record "ADT Requisition Header";
        DocumentTotals: Codeunit "Document Totals";
        gvNFLRequisitionHeader: Record "ADT Requisition Header";
        RefreshMessageEnabled: Boolean;
        TotalAmountStyle: Text;
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        RefreshMessageText: Text;
        globalVarNFLRequisitionHeader: Record "ADT Requisition Header";
        RecState: Boolean;

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
    /// Description for OpenItemTrackingLines.
    /// </summary>
    procedure OpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines;
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
    var
        PurchHeader: Record "ADT Requisition Header";
        PurchPriceCalcMgt: Codeunit "Fleet Management";
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    /// <summary>
    /// Description for ShowLineDisc.
    /// </summary>
    procedure ShowLineDisc();
    var
        PurchHeader: Record "ADT Requisition Header";
        PurchPriceCalcMgt: Codeunit "Fleet Management";
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
    /// Description for NoOnAfterValidate.
    /// </summary>
    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    /// <summary>
    /// Description for CrossReferenceNoOnAfterValidat.
    /// </summary>
    local procedure CrossReferenceNoOnAfterValidat();
    begin
        InsertExtendedText(FALSE);
    end;

    /// <summary>
    /// Description for UpdateHeader.
    /// </summary>
    /// <param name="Operation">Parameter of type Option Delete,Modify.</param>
    local procedure UpdateHeader(Operation: Option Delete,Modify);
    var
    // PaymentRequisitionHeader : Record "50000";
    // PaymentRequisitionHeader2 : Record "50000";
    begin

        /*
        globalVarNFLRequisitionHeader.RESET;
        globalVarNFLRequisitionHeader.SETRANGE("No.", "Document No.");
        IF globalVarNFLRequisitionHeader.FINDFIRST THEN BEGIN
          globalVarNFLRequisitionHeader.CALCFIELDS("Amount Including VAT","Budget Amount", "Commited Amount", "Actual Amount");
          IF Operation = Operation::Modify THEN
            globalVarNFLRequisitionHeader."Amount Including VAT" := (globalVarNFLRequisitionHeader."Amount Including VAT" - xRec."Amount Including VAT") + "Amount Including VAT";
          IF Operation = Operation::Delete THEN
            globalVarNFLRequisitionHeader."Amount Including VAT" := (globalVarNFLRequisitionHeader."Amount Including VAT") - "Amount Including VAT";
          globalVarNFLRequisitionHeader.VALIDATE("Balance on Budget");
          globalVarNFLRequisitionHeader.MODIFY;
        END ;
         */

    end;
}
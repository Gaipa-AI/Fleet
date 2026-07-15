table 50001 "ADT Requisition Header"
{
    Caption = 'ADT Requisition Header';
    DataCaptionFields = "No.", "Buy-from Vendor Name", "Request-By Name";

    fields
    {
        field(1; "Document Type"; Enum "Requisition Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
                   (xRec."Buy-from Vendor No." <> '')
                THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text004, FALSE, FIELDCAPTION("Buy-from Vendor No."));
                    IF Confirmed THEN BEGIN
                        ReqnLine.SETRANGE("Document Type", "Document Type");
                        ReqnLine.SETRANGE("Document No.", "No.");
                        IF "Buy-from Vendor No." = '' THEN BEGIN
                            IF NOT ReqnLine.ISEMPTY THEN
                                ERROR(
                                  Text005,
                                  FIELDCAPTION("Buy-from Vendor No."));
                            INIT;
                            PurchSetup.GET;
                            "No. Series" := xRec."No. Series";
                            InitRecord;
                            IF xRec."Receiving No." <> '' THEN BEGIN
                                "Receiving No. Series" := xRec."Receiving No. Series";
                                "Receiving No." := xRec."Receiving No.";
                            END;
                            IF xRec."Posting No." <> '' THEN BEGIN
                                "Posting No. Series" := xRec."Posting No. Series";
                                "Posting No." := xRec."Posting No.";
                            END;
                            IF xRec."Return Shipment No." <> '' THEN BEGIN
                                "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                                "Return Shipment No." := xRec."Return Shipment No.";
                            END;
                            IF xRec."Prepayment No." <> '' THEN BEGIN
                                "Prepayment No. Series" := xRec."Prepayment No. Series";
                                "Prepayment No." := xRec."Prepayment No.";
                            END;
                            IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                                "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                                "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                            END;
                            EXIT;
                        END;
                        IF "Document Type" = "Document Type"::"Purchase Requisition" THEN
                            ReqnLine.SETFILTER("Quantity Received", '<>0');

                        IF ReqnLine.FINDFIRST THEN
                            IF "Document Type" = "Document Type"::"Purchase Requisition" THEN
                                ReqnLine.TESTFIELD("Quantity Received", 0)
                            ELSE
                                ReqnLine.TESTFIELD("Receipt No.", '');

                        ReqnLine.SETRANGE("Receipt No.");
                        ReqnLine.SETRANGE("Quantity Received");
                        ReqnLine.SETRANGE("Buy-from Vendor No.");

                        IF "Document Type" = "Document Type"::"Purchase Requisition" THEN BEGIN
                            ReqnLine.SETFILTER("Prepmt. Amt. Inv.", '<>0');
                            IF ReqnLine.FIND('-') THEN
                                ReqnLine.TESTFIELD("Prepmt. Amt. Inv.", 0);
                            ReqnLine.SETRANGE("Prepmt. Amt. Inv.");
                        END;

                        ReqnLine.RESET;
                    END ELSE BEGIN
                        Rec := xRec;
                        EXIT;
                    END;
                END;

                GetVend("Buy-from Vendor No.");
                Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                Vend.TESTFIELD("Gen. Bus. Posting Group");
                "Buy-from Vendor Name" := Vend.Name;
                "Buy-from Vendor Name 2" := Vend."Name 2";
                "Buy-from Address" := Vend.Address;
                "Buy-from Address 2" := Vend."Address 2";
                "Buy-from City" := Vend.City;
                "Buy-from Post Code" := Vend."Post Code";
                "Buy-from County" := Vend.County;
                "Buy-from Country/Region Code" := Vend."Country/Region Code";
                IF NOT SkipBuyFromContact THEN
                    "Buy-from Contact" := Vend.Contact;
                "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
                "Tax Area Code" := Vend."Tax Area Code";
                "Tax Liable" := Vend."Tax Liable";
                "VAT Country/Region Code" := Vend."Country/Region Code";
                "VAT Registration No." := Vend."VAT Registration No.";
                VALIDATE("Lead Time Calculation", Vend."Lead Time Calculation");
                "Responsibility Center" := UserMgt.GetRespCenter(1, Vend."Responsibility Center");
                VALIDATE("Sell-to Customer No.", '');
                VALIDATE("Location Code", UserMgt.GetLocation(1, Vend."Location Code", "Responsibility Center"));

                IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
                    IF "ReceivedPurchLinesExist`" OR ReturnShipmentExist THEN BEGIN
                        TESTFIELD("VAT Bus. Posting Group", xRec."VAT Bus. Posting Group");
                        TESTFIELD("Gen. Bus. Posting Group", xRec."Gen. Bus. Posting Group");
                    END;
                END;

                "Buy-from IC Partner Code" := Vend."IC Partner Code";
                "Send IC Document" := ("Buy-from IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

                IF Vend."Pay-to Vendor No." <> '' THEN
                    VALIDATE("Pay-to Vendor No.", Vend."Pay-to Vendor No.")
                ELSE BEGIN
                    IF "Buy-from Vendor No." = "Pay-to Vendor No." THEN
                        SkipPayToContact := TRUE;
                    VALIDATE("Pay-to Vendor No.", "Buy-from Vendor No.");
                    SkipPayToContact := FALSE;
                END;
                "Order Address Code" := '';

                VALIDATE("Order Address Code");

                IF (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") OR
                   (xRec."Currency Code" <> "Currency Code") OR
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                THEN
                    RecreatePurchLines(FIELDCAPTION("Buy-from Vendor No."));

                IF NOT SkipBuyFromContact THEN
                    UpdateBuyFromCont("Buy-from Vendor No.");
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
                   (xRec."Pay-to Vendor No." <> '')
                THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text004, FALSE, FIELDCAPTION("Pay-to Vendor No."));
                    IF Confirmed THEN BEGIN
                        ReqnLine.SETRANGE("Document Type", "Document Type");
                        ReqnLine.SETRANGE("Document No.", "No.");

                        IF "Document Type" = "Document Type"::"Purchase Requisition" THEN
                            ReqnLine.SETFILTER("Quantity Received", '<>0');
                        IF ReqnLine.FINDFIRST THEN
                            IF "Document Type" = "Document Type"::"Purchase Requisition" THEN
                                ReqnLine.TESTFIELD("Quantity Received", 0)
                            ELSE
                                ReqnLine.TESTFIELD("Receipt No.", '');

                        ReqnLine.SETRANGE("Receipt No.");
                        ReqnLine.SETRANGE("Quantity Received");

                        IF "Document Type" = "Document Type"::"Purchase Requisition" THEN BEGIN
                            ReqnLine.SETFILTER("Prepmt. Amt. Inv.", '<>0');
                            IF ReqnLine.FIND('-') THEN
                                ReqnLine.TESTFIELD("Prepmt. Amt. Inv.", 0);
                            ReqnLine.SETRANGE("Prepmt. Amt. Inv.");
                        END;
                        ReqnLine.RESET;
                    END ELSE
                        Rec."Pay-to Vendor No." := xRec."Pay-to Vendor No.";
                END;

                GetVend("Pay-to Vendor No.");
                Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                Vend.TESTFIELD("Vendor Posting Group");

                "Pay-to Name" := Vend.Name;
                "Pay-to Name 2" := Vend."Name 2";
                "Pay-to Address" := Vend.Address;
                "Pay-to Address 2" := Vend."Address 2";
                "Pay-to City" := Vend.City;
                "Pay-to Post Code" := Vend."Post Code";
                "Pay-to County" := Vend.County;
                "Pay-to Country/Region Code" := Vend."Country/Region Code";
                IF NOT SkipPayToContact THEN
                    "Pay-to Contact" := Vend.Contact;
                "Payment Terms Code" := Vend."Payment Terms Code";
                "Shipment Method Code" := Vend."Shipment Method Code";
                "Vendor Posting Group" := Vend."Vendor Posting Group";
                "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
                GLSetup.GET;
                IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN
                    "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
                "Prices Including VAT" := Vend."Prices Including VAT";
                "Currency Code" := Vend."Currency Code";
                "Invoice Disc. Code" := Vend."Invoice Disc. Code";
                "Language Code" := Vend."Language Code";
                "Purchaser Code" := Vend."Purchaser Code";
                VALIDATE("Payment Terms Code");
                VALIDATE("Payment Method Code");
                VALIDATE("Currency Code");
                "VAT Registration No." := Vend."VAT Registration No.";
                IF "Document Type" = "Document Type"::"Purchase Requisition" THEN
                    "Prepayment %" := Vend."Prepayment %";

                IF "Pay-to Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
                    IF "ReceivedPurchLinesExist`" THEN
                        TESTFIELD("Currency Code", xRec."Currency Code");
                END;
                IF NOT SkipPayToContact THEN
                    UpdatePayToCont("Pay-to Vendor No.");

                "Pay-to IC Partner Code" := Vend."IC Partner Code";

            end;
        }
        field(5; "Pay-to Name"; Text[50])
        {
            Caption = 'Pay-to Name';
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Pay-to Name 2';
        }
        field(7; "Pay-to Address"; Text[50])
        {
            Caption = 'Pay-to Address';
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Pay-to Address 2';
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
            trigger OnValidate();
            begin
                PostCode.ValidateCity(
                  "Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(10; "Pay-to Contact"; Text[50])
        {
            Caption = 'Pay-to Contact';
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));

            trigger OnValidate();
            begin
                IF ("Document Type" = "Document Type"::"Purchase Requisition") AND
                   (xRec."Ship-to Code" <> "Ship-to Code")
                THEN BEGIN
                    ReqnLine.SETRANGE("Document Type", ReqnLine."Document Type"::"Purchase Requisition");
                    ReqnLine.SETRANGE("Document No.", "No.");
                    ReqnLine.SETFILTER("Sales Order Line No.", '<>0');
                    IF NOT ReqnLine.ISEMPTY THEN
                        ERROR(
                          Text006,
                          FIELDCAPTION("Ship-to Code"));
                END;

                IF "Ship-to Code" <> '' THEN BEGIN
                    ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                    "Ship-to Name" := ShipToAddr.Name;
                    "Ship-to Name 2" := ShipToAddr."Name 2";
                    "Ship-to Address" := ShipToAddr.Address;
                    "Ship-to Address 2" := ShipToAddr."Address 2";
                    "Ship-to City" := ShipToAddr.City;
                    "Ship-to Post Code" := ShipToAddr."Post Code";
                    "Ship-to County" := ShipToAddr.County;
                    "Ship-to Country/Region Code" := ShipToAddr."Country/Region Code";
                    "Ship-to Contact" := ShipToAddr.Contact;
                    "Shipment Method Code" := ShipToAddr."Shipment Method Code";
                    IF ShipToAddr."Location Code" <> '' THEN
                        VALIDATE("Location Code", ShipToAddr."Location Code");
                END ELSE BEGIN
                    TESTFIELD("Sell-to Customer No.");
                    Cust.GET("Sell-to Customer No.");
                    "Ship-to Name" := Cust.Name;
                    "Ship-to Name 2" := Cust."Name 2";
                    "Ship-to Address" := Cust.Address;
                    "Ship-to Address 2" := Cust."Address 2";
                    "Ship-to City" := Cust.City;
                    "Ship-to Post Code" := Cust."Post Code";
                    "Ship-to County" := Cust.County;
                    "Ship-to Country/Region Code" := Cust."Country/Region Code";
                    "Ship-to Contact" := Cust.Contact;
                    "Shipment Method Code" := Cust."Shipment Method Code";
                    IF Cust."Location Code" <> '' THEN
                        VALIDATE("Location Code", Cust."Location Code");
                END;
            end;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            trigger OnValidate();
            begin
                PostCode.ValidateCity(
                  "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF ("Document Type" IN ["Document Type"::"Store Requisition", "Document Type"::"Purchase Requisition"]) AND
                   NOT ("Order Date" = xRec."Order Date")
                THEN
                    PriceMessageIfPurchLinesExist(FIELDCAPTION("Order Date"));
            end;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate();
            begin
                TestNoSeriesDate(
                  "Posting No.", "Posting No. Series",
                  FIELDCAPTION("Posting No."), FIELDCAPTION("Posting No. Series"));
                TestNoSeriesDate(
                  "Prepayment No.", "Prepayment No. Series",
                  FIELDCAPTION("Prepayment No."), FIELDCAPTION("Prepayment No. Series"));
                TestNoSeriesDate(
                  "Prepmt. Cr. Memo No.", "Prepmt. Cr. Memo No. Series",
                  FIELDCAPTION("Prepmt. Cr. Memo No."), FIELDCAPTION("Prepmt. Cr. Memo No. Series"));

                VALIDATE("Document Date", "Posting Date");
                PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));

                IF "Currency Code" <> '' THEN BEGIN
                    UpdateCurrencyFactor;
                    IF "Currency Factor" <> xRec."Currency Factor" THEN
                        ConfirmUpdateCurrencyFactor;
                END;
                IF ReqnLinesExist THEN
                    JobUpdatePurchLines;

                GetFiscalYearAndAccountingPeriod("Posting Date");
                IF ReqnLinesExist THEN
                    UpdateAllLineDateFilters("Posting Date");
            end;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION("Expected Receipt Date"));
            end;
        }
        field(22; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate();
            begin
                IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                    "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Document Date");
                    VALIDATE("Payment Discount %", PaymentTerms."Discount %")
                END ELSE BEGIN
                    VALIDATE("Due Date", "Document Date");
                    VALIDATE("Pmt. Discount Date", 0D);
                    VALIDATE("Payment Discount %", 0);
                END;
                IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
                    VALIDATE("Prepmt. Payment Terms Code", "Payment Terms Code");
            end;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                IF NOT (CurrFieldNo IN [0, FIELDNO("Posting Date"), FIELDNO("Document Date")]) THEN
                    TESTFIELD(Status, Status::Open);
                GLSetup.GET;
                IF "Payment Discount %" < GLSetup."VAT Tolerance %" THEN
                    "VAT Base Discount %" := "Payment Discount %"
                ELSE
                    "VAT Base Discount %" := GLSetup."VAT Tolerance %";
                VALIDATE("VAT Base Discount %");
            end;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF ("Location Code" <> xRec."Location Code") AND
                   (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
                THEN
                    MessageIfPurchLinesExist(FIELDCAPTION("Location Code"));

                UpdateShipToAddress;

                IF "Location Code" = '' THEN BEGIN
                    IF InvtSetup.GET THEN
                        "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                END ELSE BEGIN
                    IF Location.GET("Location Code") THEN;
                    "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                END;
            end;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                UpdateAllLineDateFilters("Posting Date");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate();
            begin
                IF NOT (CurrFieldNo IN [0, FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
                    TESTFIELD(Status, Status::Open);
                IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
                    UpdateCurrencyFactor
                ELSE BEGIN
                    IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                        UpdateCurrencyFactor;
                        RecreatePurchLines(FIELDCAPTION("Currency Code"));
                    END ELSE
                        IF "Currency Code" <> '' THEN BEGIN
                            UpdateCurrencyFactor;
                            IF "Currency Factor" <> xRec."Currency Factor" THEN
                                ConfirmUpdateCurrencyFactor;
                        END;
                END;
            end;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate();
            begin
                IF "Currency Factor" <> xRec."Currency Factor" THEN
                    UpdatePurchLines(FIELDCAPTION("Currency Factor"));
            end;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate();
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
                TESTFIELD(Status, Status::Open);

                IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
                    ReqnLine.SETRANGE("Document Type", "Document Type");
                    ReqnLine.SETRANGE("Document No.", "No.");
                    ReqnLine.SETFILTER("Direct Unit Cost", '<>%1', 0);
                    ReqnLine.SETFILTER("VAT %", '<>%1', 0);
                    IF ReqnLine.FINDFIRST THEN BEGIN
                        RecalculatePrice :=
                          CONFIRM(
                            STRSUBSTNO(
                              Text025 +
                              Text027,
                              FIELDCAPTION("Prices Including VAT"), ReqnLine.FIELDCAPTION("Direct Unit Cost")),
                            TRUE);
                        IF "Currency Code" = '' THEN
                            Currency.InitRoundingPrecision
                        ELSE
                            Currency.GET("Currency Code");

                        REPEAT
                            ReqnLine.TESTFIELD("Quantity Invoiced", 0);
                            ReqnLine.TESTFIELD("Prepmt. Amt. Inv.", 0);
                            IF NOT RecalculatePrice THEN BEGIN
                                ReqnLine."VAT Difference" := 0;
                                ReqnLine.InitOutstandingAmount;
                            END ELSE
                                IF "Prices Including VAT" THEN BEGIN
                                    ReqnLine."Direct Unit Cost" :=
                                      ROUND(
                                        ReqnLine."Direct Unit Cost" * (1 + ReqnLine."VAT %" / 100),
                                        Currency."Unit-Amount Rounding Precision");
                                    IF ReqnLine.Quantity <> 0 THEN BEGIN
                                        ReqnLine."Line Discount Amount" :=
                                          ROUND(
                                            ReqnLine.Quantity * ReqnLine."Direct Unit Cost" * ReqnLine."Line Discount %" / 100,
                                            Currency."Amount Rounding Precision");
                                        ReqnLine.VALIDATE("Inv. Discount Amount",
                                          ROUND(
                                            ReqnLine."Inv. Discount Amount" * (1 + ReqnLine."VAT %" / 100),
                                            Currency."Amount Rounding Precision"));
                                    END;
                                END ELSE BEGIN
                                    ReqnLine."Direct Unit Cost" :=
                                      ROUND(
                                        ReqnLine."Direct Unit Cost" / (1 + ReqnLine."VAT %" / 100),
                                        Currency."Unit-Amount Rounding Precision");
                                    IF ReqnLine.Quantity <> 0 THEN BEGIN
                                        ReqnLine."Line Discount Amount" :=
                                          ROUND(
                                            ReqnLine.Quantity * ReqnLine."Direct Unit Cost" * ReqnLine."Line Discount %" / 100,
                                            Currency."Amount Rounding Precision");
                                        ReqnLine.VALIDATE("Inv. Discount Amount",
                                          ROUND(
                                            ReqnLine."Inv. Discount Amount" / (1 + ReqnLine."VAT %" / 100),
                                            Currency."Amount Rounding Precision"));
                                    END;
                                END;
                            ReqnLine.MODIFY;
                        UNTIL ReqnLine.NEXT = 0;
                    END;
                END;
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                MessageIfPurchLinesExist(FIELDCAPTION("Invoice Disc. Code"));
            end;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;

            trigger OnValidate();
            begin
                MessageIfPurchLinesExist(FIELDCAPTION("Language Code"));
            end;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate();
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                ApprovalEntry.SETRANGE("Table ID", DATABASE::"ADT Requisition Header");
                ApprovalEntry.SETRANGE("Document Type", "Document Type");
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Canceled, ApprovalEntry.Status::Rejected);
                IF ApprovalEntry.FIND('-') THEN
                    ERROR(Text042, FIELDCAPTION("Purchaser Code"));
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                             "No." = FIELD("No."),
                                                             "Document Line No." = CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup();
            begin
                TESTFIELD("Bal. Account No.", '');
                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
                VendLedgEntry.SETRANGE("Vendor No.", "Pay-to Vendor No.");
                VendLedgEntry.SETRANGE(Open, TRUE);
                IF "Applies-to Doc. No." <> '' THEN BEGIN
                    VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                    VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                    IF VendLedgEntry.FINDFIRST THEN;
                    VendLedgEntry.SETRANGE("Document Type");
                    VendLedgEntry.SETRANGE("Document No.");
                END ELSE
                    IF "Applies-to Doc. Type" <> 0 THEN BEGIN
                        VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                        IF VendLedgEntry.FINDFIRST THEN;
                        VendLedgEntry.SETRANGE("Document Type");
                    END ELSE
                        IF Amount <> 0 THEN BEGIN
                            VendLedgEntry.SETRANGE(Positive, Amount < 0);
                            IF VendLedgEntry.FINDFIRST THEN;
                            VendLedgEntry.SETRANGE(Positive);
                        END;
                ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                ApplyVendEntries.SETRECORD(VendLedgEntry);
                ApplyVendEntries.LOOKUPMODE(TRUE);
                IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    ApplyVendEntries.GetVendLedgEntry(VendLedgEntry);
                    GenJnlApply.CheckAgainstApplnCurrency(
                      "Currency Code", VendLedgEntry."Currency Code", GenJnILine."Account Type"::Vendor, TRUE);
                    "Applies-to Doc. Type" := VendLedgEntry."Document Type";
                    "Applies-to Doc. No." := VendLedgEntry."Document No.";
                END;
                CLEAR(ApplyVendEntries);
            end;

            trigger OnValidate();
            begin
                IF "Applies-to Doc. No." <> '' THEN
                    TESTFIELD("Bal. Account No.", '');

                IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." <> '') AND
                   ("Applies-to Doc. No." <> '')
                THEN BEGIN
                    SetAmountToApply("Applies-to Doc. No.", "Buy-from Vendor No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Buy-from Vendor No.");
                END ELSE
                    IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." = '') THEN
                        SetAmountToApply("Applies-to Doc. No.", "Buy-from Vendor No.")
                    ELSE
                        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND ("Applies-to Doc. No." = '') THEN
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Buy-from Vendor No.");
            end;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";

            trigger OnValidate();
            begin
                IF "Bal. Account No." <> '' THEN
                    CASE "Bal. Account Type" OF
                        "Bal. Account Type"::"G/L Account":
                            BEGIN
                                GLAcc.GET("Bal. Account No.");
                                GLAcc.CheckGLAcc;
                                GLAcc.TESTFIELD("Direct Posting", TRUE);
                            END;
                        "Bal. Account Type"::"Bank Account":
                            BEGIN
                                BankAcc.GET("Bal. Account No.");
                                BankAcc.TESTFIELD(Blocked, FALSE);
                                BankAcc.TESTFIELD("Currency Code", "Currency Code");
                            END;
                    END;
            end;
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("ADT Requisition Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("ADT Requisition Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                          "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(66; "Vendor Order No."; Code[20])
        {
            Caption = 'Vendor Order No.';
        }
        field(67; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(68; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(69; "Vendor Cr. Memo No."; Code[20])
        {
            Caption = 'Vendor Cr. Memo No.';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(72; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate();
            begin
                IF ("Document Type" = "Document Type"::"Purchase Requisition") AND
                   (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
                THEN BEGIN
                    ReqnLine.SETRANGE("Document Type", ReqnLine."Document Type"::"Purchase Requisition");
                    ReqnLine.SETRANGE("Document No.", "No.");
                    ReqnLine.SETFILTER("Sales Order Line No.", '<>0');
                    IF NOT ReqnLine.ISEMPTY THEN
                        ERROR(
                          Text006,
                          FIELDCAPTION("Sell-to Customer No."));
                END;

                IF "Sell-to Customer No." = '' THEN
                    VALIDATE("Location Code", UserMgt.GetLocation(1, '', "Responsibility Center"))
                ELSE
                    VALIDATE("Ship-to Code", '');
            end;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
                THEN
                    IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") THEN BEGIN
                        "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
                        RecreatePurchLines(FIELDCAPTION("Gen. Bus. Posting Group"));
                    END;
            end;
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION("Transaction Type"));
            end;
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION("Transport Method"));
            end;
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; "Buy-from Vendor Name"; Text[50])
        {
            Caption = 'Buy-from Vendor Name';
        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        field(81; "Buy-from Address"; Text[50])
        {
            Caption = 'Buy-from Address';
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Buy-from Address 2';
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
            trigger OnValidate();
            begin
                PostCode.ValidateCity(
                  "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;
        }
        field(84; "Buy-from Contact"; Text[50])
        {
            Caption = 'Buy-from Contact';
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Pay-to Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(
                  "Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(86; "Pay-to County"; Text[30])
        {
            Caption = 'Pay-to County';
        }
        field(87; "Pay-to Country/Region Code"; Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Buy-from Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(
                  "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(89; "Buy-from County"; Text[30])
        {
            Caption = 'Buy-from County';
        }
        field(90; "Buy-from Country/Region Code"; Code[10])
        {
            Caption = 'Buy-from Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate();
            begin
                "VAT Country/Region Code" := "Buy-from Country/Region Code";
            end;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(
                  "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));

            trigger OnValidate();
            var
                PayToVend: Record Vendor;
            begin
                IF "Order Address Code" <> '' THEN BEGIN
                    OrderAddr.GET("Buy-from Vendor No.", "Order Address Code");
                    "Buy-from Vendor Name" := OrderAddr.Name;
                    "Buy-from Vendor Name 2" := OrderAddr."Name 2";
                    "Buy-from Address" := OrderAddr.Address;
                    "Buy-from Address 2" := OrderAddr."Address 2";
                    "Buy-from City" := OrderAddr.City;
                    "Buy-from Contact" := OrderAddr.Contact;
                    "Buy-from Post Code" := OrderAddr."Post Code";
                    "Buy-from County" := OrderAddr.County;
                    "Buy-from Country/Region Code" := OrderAddr."Country/Region Code";
                    "VAT Country/Region Code" := OrderAddr."Country/Region Code";

                END ELSE BEGIN
                    GetVend("Buy-from Vendor No.");
                    "Buy-from Vendor Name" := Vend.Name;
                    "Buy-from Vendor Name 2" := Vend."Name 2";
                    "Buy-from Address" := Vend.Address;
                    "Buy-from Address 2" := Vend."Address 2";
                    "Buy-from City" := Vend.City;
                    "Buy-from Contact" := Vend.Contact;
                    "Buy-from Post Code" := Vend."Post Code";
                    "Buy-from County" := Vend.County;
                    "Buy-from Country/Region Code" := Vend."Country/Region Code";
                    "VAT Country/Region Code" := Vend."Country/Region Code";
                END;
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION("Entry Point"));
            end;
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';

            trigger OnValidate();
            begin
                VALIDATE("Payment Terms Code");
                VALIDATE("Prepmt. Payment Terms Code");
            end;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION(Area));
            end;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";

            trigger OnValidate();
            begin
                UpdatePurchLines(FIELDCAPTION("Transaction Specification"));
            end;
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate();
            begin
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                    PaymentMethod.GET("Payment Method Code");
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                    TESTFIELD("Applies-to Doc. No.", '');
                    TESTFIELD("Applies-to ID", '');
                END;
            end;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                WITH ReqnHeader DO BEGIN
                    ReqnHeader := Rec;
                    PurchSetup.GET;
                    TestNoSeries;
                    IF NoSeriesMgt.LookupSeries(GetPostingNoSeriesCode, "Posting No. Series") THEN
                        VALIDATE("Posting No. Series");
                    Rec := ReqnHeader;
                END;
            end;

            trigger OnValidate();
            begin
                IF "Posting No. Series" <> '' THEN BEGIN
                    PurchSetup.GET;
                    TestNoSeries;
                    NoSeriesMgt.TestSeries(GetPostingNoSeriesCode, "Posting No. Series");
                END;
                TESTFIELD("Posting No.", '');
            end;
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                WITH ReqnHeader DO BEGIN
                    ReqnHeader := Rec;
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Receipt Nos.");
                    IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Receipt Nos.", "Receiving No. Series") THEN
                        VALIDATE("Receiving No. Series");
                    Rec := ReqnHeader;
                END;
            end;

            trigger OnValidate();
            begin
                IF "Receiving No. Series" <> '' THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Receipt Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Receipt Nos.", "Receiving No. Series");
                END;
                TESTFIELD("Receiving No.", '');
            end;
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                MessageIfPurchLinesExist(FIELDCAPTION("Tax Area Code"));
            end;
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                MessageIfPurchLinesExist(FIELDCAPTION("Tax Liable"));
            end;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                THEN
                    RecreatePurchLines(FIELDCAPTION("VAT Bus. Posting Group"));
            end;
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate();
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                IF "Applies-to ID" <> '' THEN
                    TESTFIELD("Bal. Account No.", '');
                IF ("Applies-to ID" <> xRec."Applies-to ID") AND (xRec."Applies-to ID" <> '') THEN BEGIN
                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
                    VendLedgEntry.SETRANGE("Vendor No.", "Pay-to Vendor No.");
                    VendLedgEntry.SETRANGE(Open, TRUE);
                    VendLedgEntry.SETRANGE("Applies-to ID", xRec."Applies-to ID");
                    IF VendLedgEntry.FINDFIRST THEN
                        VendEntrySetApplID.SetApplId(VendLedgEntry, TempVendLedgEntry, '');
                    VendLedgEntry.RESET;
                END;
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                GLSetup.GET;
                IF "VAT Base Discount %" > GLSetup."VAT Tolerance %" THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed :=
                          CONFIRM(
                            Text007 +
                            Text008, FALSE,
                            FIELDCAPTION("VAT Base Discount %"),
                            GLSetup.FIELDCAPTION("VAT Tolerance %"),
                            GLSetup.TABLECAPTION);
                    IF NOT Confirmed THEN
                        "VAT Base Discount %" := xRec."VAT Base Discount %";
                END;

                IF ("VAT Base Discount %" = xRec."VAT Base Discount %") AND
                   (CurrFieldNo <> 0)
                THEN
                    EXIT;

                ReqnLine.SETRANGE("Document Type", "Document Type");
                ReqnLine.SETRANGE("Document No.", "No.");
                ReqnLine.SETFILTER(Type, '<>%1', ReqnLine.Type::" ");
                ReqnLine.SETFILTER(Quantity, '<>0');

                ReqnLine.LOCKTABLE;
                IF ReqnLine.FINDSET THEN BEGIN
                    MODIFY;
                    REPEAT
                        ReqnLine.UpdateAmounts;
                        ReqnLine.MODIFY;
                    UNTIL ReqnLine.NEXT = 0;
                END;
                ReqnLine.RESET;
            end;
        }
        field(120; Status; Enum "Document Status")
        {
            Caption = 'Status';
            Editable = true;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';

            trigger OnValidate();
            begin
                IF "Send IC Document" THEN BEGIN
                    TESTFIELD("Buy-from IC Partner Code");
                    TESTFIELD("IC Direction", "IC Direction"::Outgoing);
                END;
            end;
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;

            trigger OnValidate();
            begin
                IF "IC Direction" = "IC Direction"::Incoming THEN
                    "Send IC Document" := FALSE;
            end;
        }
        field(130; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(131; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Sales Invoice Header";
        }
        field(132; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(133; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Sales Invoice Header";
        }
        field(134; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                IF CurrFieldNo <> 0 THEN
                    UpdatePurchLines(FIELDCAPTION("Prepayment %"));
            end;
        }
        field(135; "Prepayment No. Series"; Code[10])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                WITH ReqnHeader DO BEGIN
                    ReqnHeader := Rec;
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Prepmt. Inv. Nos.");
                    IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Prepmt. Inv. Nos.", "Prepayment No. Series") THEN
                        VALIDATE("Prepayment No. Series");
                    Rec := ReqnHeader;
                END;
            end;

            trigger OnValidate();
            begin
                IF "Prepayment No. Series" <> '' THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Prepmt. Inv. Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Prepmt. Inv. Nos.", "Prepayment No. Series");
                END;
                TESTFIELD("Prepayment No. Series", '');
            end;
        }
        field(136; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(137; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';
        }
        field(138; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                WITH ReqnHeader DO BEGIN
                    ReqnHeader := Rec;
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Prepmt. Cr. Memo Nos.");
                    IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Prepmt. Cr. Memo Nos.", "Prepmt. Cr. Memo No. Series") THEN
                        VALIDATE("Prepmt. Cr. Memo No. Series");
                    Rec := ReqnHeader;
                END;
            end;

            trigger OnValidate();
            begin
                IF "Prepmt. Cr. Memo No. Series" <> '' THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Prepmt. Cr. Memo Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Prepmt. Cr. Memo Nos.", "Prepmt. Cr. Memo No. Series");
                END;
                TESTFIELD("Prepmt. Cr. Memo No. Series", '');
            end;
        }
        field(139; "Prepmt. Posting Description"; Text[50])
        {
            Caption = 'Prepmt. Posting Description';
        }
        field(142; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(143; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin
                IF ("Prepmt. Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Prepmt. Payment Terms Code");
                    "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                    "Prepmt. Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Document Date");
                    VALIDATE("Prepmt. Payment Discount %", PaymentTerms."Discount %")
                END ELSE BEGIN
                    VALIDATE("Prepayment Due Date", "Document Date");
                    VALIDATE("Prepmt. Pmt. Discount Date", 0D);
                    VALIDATE("Prepmt. Payment Discount %", 0);
                END;
            end;
        }
        field(144; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                IF NOT (CurrFieldNo IN [0, FIELDNO("Posting Date"), FIELDNO("Document Date")]) THEN
                    TESTFIELD(Status, Status::Open);
                GLSetup.GET;
                IF "Payment Discount %" < GLSetup."VAT Tolerance %" THEN
                    "VAT Base Discount %" := "Payment Discount %"
                ELSE
                    "VAT Base Discount %" := GLSetup."VAT Tolerance %";
                VALIDATE("VAT Base Discount %");
            end;
        }
        field(145; "Requisition Total Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("ADT Requisition Line"."Total Cost" where("Document Type" = filter("Store Requisition"), "Document No." = field("No.")));
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(160; "Job Queue Status"; Option)
        {
            Caption = 'Job Queue Status';
            Editable = false;
            OptionCaption = ' ,Scheduled for Posting,Error,Posting';
            OptionMembers = " ","Scheduled for Posting",Error,Posting;

            trigger OnLookup();
            var
                JobQueueEntry: Record "Job Queue Entry";
            begin
                IF "Job Queue Status" = "Job Queue Status"::" " THEN
                    EXIT;
                JobQueueEntry.ShowStatusMsg("Job Queue Entry ID");
            end;
        }
        field(161; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDocDim;
            end;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Purchase Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"),
                                                                             "No." = FIELD("No."),
                                                                             "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
            trigger OnValidate();
            begin
                CreateDimFromDefaultDim(Rec.FieldNo("Campaign No."));
            end;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF "Buy-from Vendor No." <> '' THEN BEGIN
                    IF Cont.GET("Buy-from Contact No.") THEN
                        Cont.SETRANGE("Company No.", Cont."Company No.")
                    ELSE BEGIN
                        ContBusinessRelation.RESET;
                        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                        ContBusinessRelation.SETRANGE("No.", "Buy-from Vendor No.");
                        IF ContBusinessRelation.FINDFIRST THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                        ELSE
                            Cont.SETRANGE("No.", '');
                    END;
                END;

                IF "Buy-from Contact No." <> '' THEN
                    IF Cont.GET("Buy-from Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Buy-from Contact No.", Cont."No.");
                END;
            end;

            trigger OnValidate();
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                TESTFIELD(Status, Status::Open);

                IF ("Buy-from Contact No." <> xRec."Buy-from Contact No.") AND
                   (xRec."Buy-from Contact No." <> '')
                THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text004, FALSE, FIELDCAPTION("Buy-from Contact No."));
                    IF Confirmed THEN BEGIN
                        ReqnLine.SETRANGE("Document Type", "Document Type");
                        ReqnLine.SETRANGE("Document No.", "No.");
                        IF ("Buy-from Contact No." = '') AND ("Buy-from Vendor No." = '') THEN BEGIN
                            IF NOT ReqnLine.ISEMPTY THEN
                                ERROR(
                                  Text005,
                                  FIELDCAPTION("Buy-from Contact No."));
                            INIT;
                            PurchSetup.GET;
                            InitRecord;
                            "No. Series" := xRec."No. Series";
                            IF xRec."Receiving No." <> '' THEN BEGIN
                                "Receiving No. Series" := xRec."Receiving No. Series";
                                "Receiving No." := xRec."Receiving No.";
                            END;
                            IF xRec."Posting No." <> '' THEN BEGIN
                                "Posting No. Series" := xRec."Posting No. Series";
                                "Posting No." := xRec."Posting No.";
                            END;
                            IF xRec."Return Shipment No." <> '' THEN BEGIN
                                "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                                "Return Shipment No." := xRec."Return Shipment No.";
                            END;
                            IF xRec."Prepayment No." <> '' THEN BEGIN
                                "Prepayment No. Series" := xRec."Prepayment No. Series";
                                "Prepayment No." := xRec."Prepayment No.";
                            END;
                            IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                                "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                                "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                            END;
                            EXIT;
                        END;
                    END ELSE BEGIN
                        Rec := xRec;
                        EXIT;
                    END;
                END;

                IF ("Buy-from Vendor No." <> '') AND ("Buy-from Contact No." <> '') THEN BEGIN
                    Cont.GET("Buy-from Contact No.");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                    ContBusinessRelation.SETRANGE("No.", "Buy-from Vendor No.");
                    IF ContBusinessRelation.FINDFIRST THEN
                        IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                            ERROR(Text038, Cont."No.", Cont.Name, "Buy-from Vendor No.");
                END;

                UpdateBuyFromVend("Buy-from Contact No.");
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                IF "Pay-to Vendor No." <> '' THEN BEGIN
                    IF Cont.GET("Pay-to Contact No.") THEN
                        Cont.SETRANGE("Company No.", Cont."Company No.")
                    ELSE BEGIN
                        ContBusinessRelation.RESET;
                        ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                        ContBusinessRelation.SETRANGE("No.", "Pay-to Vendor No.");
                        IF ContBusinessRelation.FINDFIRST THEN
                            Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
                        ELSE
                            Cont.SETRANGE("No.", '');
                    END;
                END;

                IF "Pay-to Contact No." <> '' THEN
                    IF Cont.GET("Pay-to Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    xRec := Rec;
                    VALIDATE("Pay-to Contact No.", Cont."No.");
                END;
            end;

            trigger OnValidate();
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                TESTFIELD(Status, Status::Open);

                IF ("Pay-to Contact No." <> xRec."Pay-to Contact No.") AND
                   (xRec."Pay-to Contact No." <> '')
                THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text004, FALSE, FIELDCAPTION("Pay-to Contact No."));
                    IF Confirmed THEN BEGIN
                        ReqnLine.SETRANGE("Document Type", "Document Type");
                        ReqnLine.SETRANGE("Document No.", "No.");
                        IF ("Pay-to Contact No." = '') AND ("Pay-to Vendor No." = '') THEN BEGIN
                            IF NOT ReqnLine.ISEMPTY THEN
                                ERROR(
                                  Text005,
                                  FIELDCAPTION("Pay-to Contact No."));
                            INIT;
                            PurchSetup.GET;
                            InitRecord;
                            "No. Series" := xRec."No. Series";
                            IF xRec."Receiving No." <> '' THEN BEGIN
                                "Receiving No. Series" := xRec."Receiving No. Series";
                                "Receiving No." := xRec."Receiving No.";
                            END;
                            IF xRec."Posting No." <> '' THEN BEGIN
                                "Posting No. Series" := xRec."Posting No. Series";
                                "Posting No." := xRec."Posting No.";
                            END;
                            IF xRec."Return Shipment No." <> '' THEN BEGIN
                                "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                                "Return Shipment No." := xRec."Return Shipment No.";
                            END;
                            IF xRec."Prepayment No." <> '' THEN BEGIN
                                "Prepayment No. Series" := xRec."Prepayment No. Series";
                                "Prepayment No." := xRec."Prepayment No.";
                            END;
                            IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                                "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                                "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                            END;
                            EXIT;
                        END;
                    END ELSE BEGIN
                        "Pay-to Contact No." := xRec."Pay-to Contact No.";
                        EXIT;
                    END;
                END;

                IF ("Pay-to Vendor No." <> '') AND ("Pay-to Contact No." <> '') THEN BEGIN
                    Cont.GET("Pay-to Contact No.");
                    ContBusinessRelation.RESET;
                    ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
                    ContBusinessRelation.SETRANGE("No.", "Pay-to Vendor No.");
                    IF ContBusinessRelation.FINDFIRST THEN
                        IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                            ERROR(Text038, Cont."No.", Cont.Name, "Pay-to Vendor No.");
                END;

                UpdatePayToVend("Pay-to Contact No.");
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF NOT UserMgt.CheckRespCenter(1, "Responsibility Center") THEN
                    ERROR(
                      Text028,
                      RespCenter.TABLECAPTION, UserMgt.GetPurchasesFilter);

                "Location Code" := UserMgt.GetLocation(1, '', "Responsibility Center");
                IF "Location Code" = '' THEN BEGIN
                    IF InvtSetup.GET THEN
                        "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                END ELSE BEGIN
                    IF Location.GET("Location Code") THEN;
                    "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                END;

                UpdateShipToAddress;
                CreateDimFromDefaultDim(Rec.FieldNo("Responsibility Center"));

                IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
                    RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
                    "Assigned User ID" := '';
                END;
            end;
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = Min("Purchase Line"."Completely Received" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("No."),
                                                                           Type = FILTER(<> ' '),
                                                                           "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF "Promised Receipt Date" <> 0D THEN
                    ERROR(
                      Text034,
                      FIELDCAPTION("Requested Receipt Date"),
                      FIELDCAPTION("Promised Receipt Date"));

                IF "Requested Receipt Date" <> xRec."Requested Receipt Date" THEN
                    UpdatePurchLines(FIELDCAPTION("Requested Receipt Date"));
            end;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF "Promised Receipt Date" <> xRec."Promised Receipt Date" THEN
                    UpdatePurchLines(FIELDCAPTION("Promised Receipt Date"));
            end;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF "Lead Time Calculation" <> xRec."Lead Time Calculation" THEN
                    UpdatePurchLines(FIELDCAPTION("Lead Time Calculation"));
            end;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" THEN
                    UpdatePurchLines(FIELDCAPTION("Inbound Whse. Handling Time"));
            end;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; "Vendor Authorization No."; Code[20])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";

            trigger OnLookup();
            begin
                WITH ReqnHeader DO BEGIN
                    ReqnHeader := Rec;
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Return Shpt. Nos.");
                    IF NoSeriesMgt.LookupSeries(PurchSetup."Posted Return Shpt. Nos.", "Return Shipment No. Series") THEN
                        VALIDATE("Return Shipment No. Series");
                    Rec := ReqnHeader;
                END;
            end;

            trigger OnValidate();
            begin
                IF "Return Shipment No. Series" <> '' THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Posted Return Shpt. Nos.");
                    NoSeriesMgt.TestSeries(PurchSetup."Posted Return Shpt. Nos.", "Return Shipment No. Series");
                END;
                TESTFIELD("Return Shipment No.", '');
            end;
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(5805; "Assigned User ID"; Code[100])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";

            trigger OnValidate();
            begin
                IF NOT UserMgt.CheckRespCenter(1, "Responsibility Center", "Assigned User ID") THEN
                    ERROR(Text049, "Assigned User ID", RespCenter.TABLECAPTION, UserMgt.GetPurchasesFilter("Assigned User ID"));
            end;
        }
        field(5806; "Request-By No."; Code[100])
        {
            TableRelation = Resource."No." where(Type = filter(Person), Blocked = const(false));
            trigger OnValidate();
            var
                Employee: Record Resource;
            begin
                TESTFIELD(Status, Status::Open);

                Employee.GET("Request-By No.");
                IF Employee.Name <> '' THEN
                    "Request-By Name" := Employee.Name;
                //Copy the Dimensions
                Employee.GET("Request-By No.");
                "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                VALIDATE("Shortcut Dimension 1 Code");
                VALIDATE("Shortcut Dimension 2 Code");
                ReqnLine.RESET;
                ReqnLine.SETRANGE("Document Type", "Document Type");
                ReqnLine.SETRANGE("Document No.", "No.");
                IF ReqnLine.FINDSET THEN BEGIN
                    ReqnLine.MODIFYALL("Request-By No.", "Request-By No.");
                    ReqnLine.MODIFYALL("Request-By Name", "Request-By Name");
                END;


                IF ("Request-By No." <> xRec."Request-By No.") AND
                 (xRec."Request-By No." <> '')
                 THEN BEGIN
                    IF HideValidationDialog THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text004, FALSE, FIELDCAPTION("Request-By No."));

                    IF Confirmed THEN BEGIN
                        ReqnLine.RESET;
                        ReqnLine.SETRANGE("Document Type", "Document Type");
                        ReqnLine.SETRANGE("Document No.", "No.");

                        IF ReqnLine.FINDSET THEN BEGIN
                            ReqnLine.MODIFYALL("Request-By No.", "Request-By No.");
                            ReqnLine.MODIFYALL("Request-By Name", "Request-By Name");
                        END;

                        IF "Request-By No." = '' THEN BEGIN
                            IF NOT ReqnLine.ISEMPTY THEN BEGIN
                                ERROR(
                                Text005,
                                FIELDCAPTION("Request-By No."));
                                INIT;
                                PurchSetup.GET;
                                "No. Series" := xRec."No. Series";
                                InitRecord;
                            END;

                            IF xRec."Posting No." <> '' THEN BEGIN
                                "Posting No. Series" := xRec."Posting No. Series";
                                "Posting No." := xRec."Posting No.";
                            END;

                            IF "Document Type" = "Document Type"::"Store Requisition" THEN
                                ReqnLine.SETFILTER("Qty. Requested", '<>0');
                        END;
                        ReqnLine.RESET;

                    END ELSE BEGIN
                        Rec := xRec;
                        EXIT;

                    END;
                END;
            end;
        }
        field(5807; "Request-By Name"; Text[50])
        {
            // Editable = false;
            FieldClass = Normal;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5808; "Purchase Requisition No."; Code[20])
        {
        }
        field(5809; "Created Quotes"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote)));
            FieldClass = FlowField;
        }
        field(5810; "Store Requisition No."; Code[20])
        {
        }
        field(5811; "Requestor ID"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(5812; "External Reference No."; Code[20])
        {
        }
        field(5813; "Approver ID"; Code[100])
        {
        }
        field(5814; "Procurement Plan Reference"; Code[20])
        {

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5815; "Converted to Order"; Boolean)
        {
            Caption = 'Converted to Order';
            Description = 'Ensures that the purchase requisition is converted once to an order';
            Editable = false;
        }
        field(5816; "Converted to Quote"; Boolean)
        {
            Caption = 'Converted to Quote';
            Description = 'Ensures that the purchase requisition is converted once to a quote';
            Editable = false;
        }
        field(5817; "Special Instruction/Program"; Text[100])
        {

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5818; "Delivery Period"; Text[30])
        {

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5819; Committed; Boolean)
        {
            Description = 'Identifies whether the purchase requisition has been committed';
            Editable = false;
        }
        field(5820; "To."; Text[50])
        {

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5821; "Budget Code"; Code[10])
        {
            Editable = true;
            TableRelation = "G/L Budget Name";
            

            trigger OnValidate();
            begin
                TESTFIELD("Posting Date");
                IF ReqnLinesExist THEN BEGIN
                    UpdateAllLineBudget("Budget Code");
                    UpdateAllLineDateFilters("Posting Date");
                END;
            end;
        }
        field(5822; Archived; Boolean)
        {
            Editable = false;
        }
        field(5823; "Sent to Budget Controller"; Boolean)
        {
            Editable = false;
        }
        field(5824; "Prepared by"; Code[50])
        {
            Editable = false;
        }
        field(5826; "Requisition Lines Total"; Decimal)
        {
            CalcFormula = Sum("ADT Requisition Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                          "Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5827; "Accounting Period Start Date"; Date)
        {
            Editable = false;
        }
        field(5828; "Accounting Period End Date"; Date)
        {
            Editable = false;
        }
        field(5829; "Fiscal Year Start Date"; Date)
        {
            Editable = false;
        }
        field(5830; "Fiscal Year End Date"; Date)
        {
            Editable = false;
        }
        field(5831; "Filter to Date Start Date"; Date)
        {
            Editable = false;
        }
        field(5832; "Filter to Date End Date"; Date)
        {
            Editable = false;
        }
        field(5833; "Quarter Start Date"; Date)
        {
            Editable = false;
        }
        field(5834; "Quarter End Date"; Date)
        {
            Editable = false;
        }
        field(5835; "Budget At Date Exceeded"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("ADT Requisition Line" where("Document No." = field("No."), Type = filter("G/L Account"), "Document Type" = field("Document Type"), "G/L Account Type" = filter("Income Statement"), "Exceeded at Date Budget" = filter(true)));
            Editable = false;
        }
        field(5836; "Month Budget Exceeded"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("ADT Requisition Line" where("Document No." = field("No."), Type = filter("G/L Account"), "Document Type" = field("Document Type"), "G/L Account Type" = filter("Income Statement"), "Exceeded Month Budget" = filter(true)));
            Editable = false;
        }
        field(5837; "Quarter Budget Exceeded"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("ADT Requisition Line" where("Document No." = field("No."), Type = filter("G/L Account"), "Document Type" = field("Document Type"), "G/L Account Type" = filter("Income Statement"), "Exceeded Quarter Budget" = filter(true)));
            Editable = false;
        }
        field(5838; "Year Budget Exceeded"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("ADT Requisition Line" where("Document No." = field("No."), Type = filter("G/L Account"), "Document Type" = field("Document Type"), "G/L Account Type" = filter("Income Statement"), "Exceeded Year Budget" = filter(true)));
            Editable = false;
        }
        field(5839; "Approvals Entry"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Approval Entry" where("Document No." = field("No."), Status = filter(open | Created)));
        }
        field(5840; Freelance; Boolean)
        {
            Caption = 'Freelance';
        }
        field(5841; "Current Approver"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("No.")));
            //, Status = filter(Open)
        }
        field(5842; "Total Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("ADT Requisition Line"."Total Cost" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(5843; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("ADT Requisition Line"."Qty. Requested" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(5844; "Return Date"; Date)
        {
        }
        field(5845; "Valid to Date"; Date)
        {
        }
        field(5846; "PD Entity"; Text[60])
        {
        }
        field(5847; "Procurement Category"; Option)
        {
            OptionCaption = ' ,Supplies,Works and Construction,Services';
            OptionMembers = " ",Supplies,"Works and Construction",Services;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(5848; "ITB Number"; Code[20])
        {
        }
        field(5849; "Contract No."; Code[20])
        {
        }
        field(5850; "Release date"; Date)
        {
        }
        field(5851; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
        field(5852; "Time Received"; Time)
        {
            Caption = 'Time Received';
        }
        field(5853; "BizTalk Purchase Quote"; Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
        }
        field(5854; "BizTalk Purch. Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
        }
        field(5855; "BizTalk Purchase Invoice"; Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
        }
        field(5856; "BizTalk Purchase Receipt"; Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
        }
        field(5857; "BizTalk Purchase Credit Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
        }
        field(5858; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(5859; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(5860; "BizTalk Request for Purch. Qte"; Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
        }
        field(5861; "BizTalk Purchase Order"; Boolean)
        {
            Caption = 'BizTalk Purchase Order';
        }
        field(5862; "Vendor Quote No."; Code[20])
        {
            Caption = 'Vendor Quote No.';
        }
        field(5863; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
        field(5864; "Wrks/Srvcs/Sup"; Option)
        {
            Description = 'Added to design form 5 Report';
            OptionCaption = 'Supplies,Works,Non-Consultancy Services';
            OptionMembers = Supplies,Works,"Non-Consultancy Services";
        }
        field(5865; "Hub Code"; Code[50])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SUB COST CENTRE'), Blocked = filter(false));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(8, "Hub Code");
            end;
        }
        field(5866; Process; Boolean)
        {
        }
        field(5867; "Request Type"; Enum "Request Type")
        {

        }
        field(5868; "Raised By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup"."User ID";
        }
        field(5869; "Received By"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5870; "Ticket No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5871; "Customer Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(customer.Name where("No." = field("Sell-to Customer No.")));
        }
        field(5872; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5873; "Equipment No."; code[100])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
                RequisitionLine: record "ADT Requisition Line";
            begin
                IF "Equipment No." <> '' THEN BEGIN
                    IF Equipment.GET("Equipment No.") THEN BEGIN
                        Equipment.TestField("Equipment Type");
                        IF Equipment."Blocked" THEN
                            ERROR('Equipment: %1 is blocked.', Equipment."No.")
                        else begin
                            // Update the lines
                            RequisitionLine.Reset();
                            RequisitionLine.SetRange("Document Type", Rec."Document Type");
                            RequisitionLine.SetRange("Document No.", Rec."No.");
                            if RequisitionLine.FindSet() then begin
                                repeat
                                    RequisitionLine.Validate("Equipment No.", Rec."Equipment No.");
                                    RequisitionLine.Modify();
                                until RequisitionLine.Next() = 0;
                            end;
                            Rec.Validate("Responsible Employee", Equipment."Responsible Employee");
                            Rec.Validate("Driver No.", Equipment."Responsible Employee");
                            Rec.Validate("Equipment RegNo.", Equipment."Registration No.");
                            Rec.validate("Equipment Type", Equipment."Equipment Type");
                            Rec.Modify();
                        end;
                    END;
                END else begin
                    "Equipment Type" := '';
                    Rec.Modify();

                    // Update the lines
                    RequisitionLine.Reset();
                    RequisitionLine.SetRange("Document Type", Rec."Document Type");
                    RequisitionLine.SetRange("Document No.", Rec."No.");
                    if RequisitionLine.FindSet() then begin
                        repeat
                            RequisitionLine.Validate("Equipment No.", '');
                            RequisitionLine.Modify();
                        until RequisitionLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(5874; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(5875; "Responsible Employee"; Code[50])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Rec."Responsible Employee" <> '' then begin
                    if Employee.Get(Rec."Responsible Employee") then begin
                        Rec."Employee Name" := Employee.FullName();
                        Rec.Modify();
                    end
                end;
            end;
        }
        field(5876; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5877; "Maintenance Request No."; Code[20])
        {
            TableRelation = "Maintenance Header"."No." where("Document Type" = filter("Maintenance Request"), "Status" = filter(Released), "Job Closed" = const(false), "Has a Job" = const(true));
            trigger OnValidate()
            var
                MaintenanceHeader: Record "Maintenance Header";
            begin
                Rec.TestField("Location Code");
                if MaintenanceHeader.Get(MaintenanceHeader."Document Type"::"Maintenance Request", Rec."Maintenance Request No.") then begin
                    Rec.Validate("Equipment No.", MaintenanceHeader."Equipment No.");
                    MaintenanceHeader.CalcFields("Job Card No.");
                    Rec.Validate("Job Card No.", MaintenanceHeader."Job Card No.");
                    Rec.Modify();
                end;
            end;
        }
        field(5878; "Authorize Requisition"; Boolean)
        {
            Editable = false;
        }
        field(5879; "Authorized by"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(5880; "Authorized Date"; Date)
        {
            Editable = false;
        }
        field(5881; "Released By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5882; "Driver No."; Code[20])
        {
            TableRelation = Employee."No." where(Blocked = const(false));

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."Driver No.") then begin
                    Rec.Validate("Driver Name", Employee.FullName());

                end else
                    Rec."Driver Name" := '';
                Rec.Modify();
            end;
        }
        field(5883; "Driver Name"; Text[100])
        {
            Editable = false;
        }
        field(5884; Destination; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5885; "Equipment RegNo."; code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5886; "Fuel Pick Up Location"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5887; "Job Card No."; Code[100])
        {
            TableRelation = "Maintenance Header"."No." where("Document Type" = filter("Job Card"));
            trigger OnValidate()
            begin
                Rec.TestField("Location Code");
                if Rec."Job Card No." <> '' then begin
                    Rec.TestField("Maintenance Request No.");
                    if Rec."Request Type" = Rec."Request Type"::"Spare Parts" then
                        CreateLines(Rec."Job Card No.");
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Request Type", "No.")
        {
        }
        key(Key2; "No.", "Document Type")
        {
        }
        key(Key3; "Document Type", "Buy-from Vendor No.", "No.")
        {
        }
        key(Key4; "Buy-from Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        lvStoreReqLine: Record "ADT Requisition Line";
    begin
        IF NOT UserMgt.CheckRespCenter(1, "Responsibility Center") THEN
            ERROR(
              Text023,
              RespCenter.TABLECAPTION, UserMgt.GetPurchasesFilter);

        ReqnLine.SETRANGE("Document Type", "Document Type");
        ReqnLine.SETRANGE("Document No.", "No.");
        ReqnLine.SETRANGE(Type, ReqnLine.Type::"Charge (Item)");
        DeletePurchaseLines;
        ReqnLine.SETRANGE(Type);
        DeletePurchaseLines;

        WhseRequest.SETRANGE("Source Type", DATABASE::"ADT Requisition Line");
        WhseRequest.SETRANGE("Source Subtype", "Document Type");
        WhseRequest.SETRANGE("Source No.", "No.");
        WhseRequest.DELETEALL(TRUE);

        ReqnLine.SETRANGE("Document Type", "Document Type");
        ReqnLine.SETRANGE("Document No.", "No.");
        ReqnLine.SETRANGE(Type, ReqnLine.Type::"Charge (Item)");
        DeletePurchaseLines;
        ReqnLine.SETRANGE(Type);
        DeletePurchaseLines;

        PurchCommentLine.SETRANGE("Document Type", "Document Type");
        PurchCommentLine.SETRANGE("No.", "No.");
        PurchCommentLine.DELETEALL;

        IF "Document Type" = "Document Type"::"Store Requisition" THEN BEGIN
            IF CONFIRM('Do you wish to delete the header and the lines?') THEN BEGIN
                lvStoreReqLine.RESET;
                lvStoreReqLine.SETFILTER("Document Type", FORMAT(lvStoreReqLine."Document Type"::"Store Requisition"));
                lvStoreReqLine.SETFILTER("Document No.", "No.");
                lvStoreReqLine.DELETEALL;
                DELETE;
            END;
        END;
    end;

    trigger OnInsert();
    begin
        PurchSetup.GET;

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;

        InitRecord;
        Rec."Prepared by" := UserId;
        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
            IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
                VALIDATE("Buy-from Vendor No.", GETRANGEMIN("Buy-from Vendor No."));

        IF GETFILTER("Request-By No.") <> '' THEN
            IF GETRANGEMIN("Request-By No.") = GETRANGEMAX("Request-By No.") THEN
                VALIDATE("Request-By No.", GETRANGEMIN("Request-By No."));

        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"ADT Requisition Header", "Document Type", "No.");

        "Requestor ID" := USERID;

        UpdateValidityDate;
    end;

    trigger OnModify();
    begin
        IF ("Document Type" = "Document Type"::"Store Requisition") AND (Status <> Status::Open) AND
        (Status <> xRec.Status) THEN;
    end;

    trigger OnRename();
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    var
        Text000: Label 'Do you want to print receipt %1?';
        Text001: Label 'Do you want to print invoice %1?';
        Text002: Label 'Do you want to print credit memo %1?';
        Text003: Label 'You cannot rename a %1.';
        Text004: Label 'Do you want to change %1? The lines will also be modified.';
        Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
        Text006: Label 'You cannot change %1 because the order is associated with one or more sales orders.';
        Text007: Label '%1 is greater than %2 in the %3 table.\';
        Text008: Label 'Confirm change?';
        Text009: Label '"Deleting this document will cause a gap in the number series for receipts. "';
        Text010: Label 'An empty receipt %1 will be created to fill this gap in the number series.\\';
        Text011: Label 'Do you want to continue?';
        Text012: Label '"Deleting this document will cause a gap in the number series for posted invoices. "';
        Text013: Label 'An empty posted invoice %1 will be created to fill this gap in the number series.\\';
        Text014: Label '"Deleting this document will cause a gap in the number series for posted credit memos. "';
        Text015: Label 'An empty posted credit memo %1 will be created to fill this gap in the number series.\\';
        Text016: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\';
        Text018: Label 'You must delete the existing purchase lines before you can change %1.';
        Text019: Label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\';
        Text020: Label 'You must update the existing purchase lines manually.';
        Text021: Label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';
        Text022: Label 'Do you want to update the exchange rate?';
        Text023: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text024: Label 'Do you want to print return shipment %1?';
        Text025: Label '"You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. "';
        Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: Label 'Your identification is set up to process from %1 %2 only.';
        Text029: Label '"Deleting this document will cause a gap in the number series for return shipments. "';
        Text030: Label 'An empty return shipment %1 will be created to fill this gap in the number series.\\';
        Text032: Label 'You have modified %1.\\';
        Text033: Label 'Do you want to update the lines?';
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        ReqnLine: Record "ADT Requisition Line";
        xReqnLine: Record "ADT Requisition Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        ReqnHeader: Record "ADT Requisition Header";
        PurchCommentLine: Record "Purch. Comment Line";
        ShipToAddr: Record "Ship-to Address";
        Cust: Record Customer;
        CompanyInfo: Record "Company Information";
        PostCode: Record "Post Code";
        OrderAddr: Record "Order Address";
        BankAcc: Record "Bank Account";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnILine: Record "Gen. Journal Line";
        RespCenter: Record "Responsibility Center";
        Location: Record Location;
        WhseRequest: Record "Warehouse Request";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PurchPost: Codeunit "Purch.-Post";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit "ArchiveManagement";
        ReserveReqnLine: Codeunit "Purch. Line-Reserve";
        ApplyVendEntries: Page "Apply Vendor Entries";
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text034: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: Label 'Contact %1 %2 is not related to vendor %3.';
        Text038: Label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: Label 'Contact %1 %2 is not related to a vendor.';
        SkipBuyFromContact: Boolean;
        SkipPayToContact: Boolean;
        Text040: TextConst ENU = 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text041: Label 'The purchase %1 %2 has item tracking. Do you want to delete it anyway?';
        Text042: Label 'You must cancel the approval process if you wish to change the %1.';
        Text043: Label 'Do you want to print prepayment invoice %1?';
        Text044: Label 'Do you want to print prepayment credit memo %1?';
        Text045: Label '"Deleting this document will cause a gap in the number series for prepayment invoices. "';
        Text046: Label 'An empty prepayment invoice %1 will be created to fill this gap in the number series.\\';
        Text047: Label '"Deleting this document will cause a gap in the number series for prepayment credit memos. "';
        Text049: Label '%1 is set up to process from %2 %3 only.';
        DoYouWantToKeepExistingDimensionsQst: Label 'This will change the dimension specified on the document. Do you want to keep the existing dimensions?';
        ANFSetup: Record "Fleet Management Setup";
        NFLPurchLine: Record "ADT Requisition Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        gvDimensionSetEntry: Record "Dimension Set Entry";
        globalVarNFLRequisitionHeader: Record "ADT Requisition Header";

    /// <summary>
    /// Description for InitRecord.
    /// </summary>
    procedure InitRecord();
    begin
        ANFSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Purchase Requisition":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Store Requisition Nos" = ANFSetup."Store Requisition Nos")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Store Requisition Nos");
                    GeneralLedgerSetup.GET;
                    "Prepared by" := USERID;
                END;

            "Document Type"::"Store Requisition":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Store Requisition Nos" = ANFSetup."Store Requisition Nos")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Store Requisition Nos");
                END;
        END;

        "Posting Date" := WORKDATE;

        IF PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" THEN
            "Posting Date" := 0D;

        "Document Date" := WORKDATE;
        IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";

        "Responsibility Center" := UserMgt.GetRespCenter(1, "Responsibility Center");

        IF "Document Type" = "Document Type"::"Store Requisition" THEN
            if "Posting Date" = 0D then
                "Posting Date" := WorkDate();

        GetFiscalYearAndAccountingPeriod("Posting Date");
    end;

    /// <summary>
    /// Description for AssistEdit.
    /// </summary>
    /// <param name="OldReqnHeader">Parameter of type Record "ADT Requisition Header".</param>
    /// <returns>Return variable "Boolean".</returns>
    procedure AssistEdit(OldReqnHeader: Record "ADT Requisition Header"): Boolean;
    begin
        ANFSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldReqnHeader."No. Series", "No. Series") THEN BEGIN
            PurchSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    /// <summary>
    /// Description for TestNoSeries.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    local procedure TestNoSeries(): Boolean;
    begin
        ANFSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Store Requisition":
                if "Request Type" = "Request Type"::Fuel then
                    ANFSetup.TESTFIELD("Fuel Requisition Nos")
                else if "Request Type" = "Request Type"::General then
                    ANFSetup.TestField("Store Requisition Nos");
            "Document Type"::"Purchase Requisition":
                if "Request Type" = "Request Type"::"Spare Parts" then
                    ANFSetup.TESTFIELD("Spare Part Requisition Nos")
                else if "Request Type" = "Request Type"::General then
                    ANFSetup.TESTFIELD("General Requisitions No.");
        END;
    end;

    /// <summary>
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "Code[10]".</returns>
    local procedure GetNoSeriesCode(): Code[10];
    begin
        CASE "Document Type" OF
            "Document Type"::"Store Requisition":
                begin
                    if "Request Type" = "Request Type"::Fuel then
                        exit(ANFSetup."Fuel Requisition Nos")
                    else if "Request Type" = "Request Type"::General then
                        Exit(ANFSetup."Store Requisition Nos");
                end;
            "Document Type"::"Purchase Requisition":
                if "Request Type" = "Request Type"::"Spare Parts" then
                    exit(ANFSetup."Spare Part Requisition Nos")
                else if "Request Type" = "Request Type"::General then
                    Exit(ANFSetup."General Requisitions No.");
        END;
    end;

    /// <summary>
    /// Description for GetPostingNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "Code[10]".</returns>
    local procedure GetPostingNoSeriesCode(): Code[10];
    begin
    end;

    /// <summary>
    /// Description for TestNoSeriesDate.
    /// </summary>
    /// <param name="No">Parameter of type Code[20].</param>
    /// <param name="NoSeriesCode">Parameter of type Code[10].</param>
    /// <param name="NoCapt">Parameter of type Text[1024].</param>
    /// <param name="NoSeriesCapt">Parameter of type Text[1024].</param>
    local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[10]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024]);
    var
        NoSeries: Record "No. Series";
    begin
        IF (No <> '') AND (NoSeriesCode <> '') THEN BEGIN
            NoSeries.GET(NoSeriesCode);
            IF NoSeries."Date Order" THEN
                ERROR(
                  Text040,
                  FIELDCAPTION("Posting Date"), NoSeriesCapt, NoSeriesCode,
                  NoSeries.FIELDCAPTION("Date Order"), NoSeries."Date Order", "Document Type",
                  NoCapt, No);
        END;
    end;

    /// <summary>
    /// Description for GetVend.
    /// </summary>
    /// <param name="VendNo">Parameter of type Code[20].</param>
    local procedure GetVend(VendNo: Code[20]);
    begin
        IF VendNo <> Vend."No." THEN
            Vend.GET(VendNo);
    end;

    procedure CreateLines(JobCardNo: code[20])
    var
        RequisitionLine: Record "ADT Requisition Line";
        RequisitionLine1: Record "ADT Requisition Line";
        RequisitionLine2: Record "ADT Requisition Line";
        LineNo: Integer;
        MaintenanceLine: Record "Maintenance Line";
    begin
        LineNo := 1000;

        //clear the requisition Lines
        RequisitionLine.RESET;
        RequisitionLine.SETRANGE("Document Type", Rec."Document Type");
        RequisitionLine.SETRANGE("Document No.", Rec."No.");
        RequisitionLine.DELETEALL;

        MaintenanceLine.Reset;
        MaintenanceLine.setrange("Document Type", MaintenanceLine."Document Type"::"Job Card");
        MaintenanceLine.setrange("Document No.", JobCardNo);
        if MaintenanceLine.FindFirst() then begin
            repeat
                RequisitionLine1.Reset();
                RequisitionLine1.SetRange("Document Type", Rec."Document Type");
                RequisitionLine1.SetRange("Document No.", Rec."No.");
                if RequisitionLine1.FindLast() then
                    LineNo := LineNo + 1000;

                RequisitionLine2.INIT;
                RequisitionLine2."Document Type" := Rec."Document Type";
                RequisitionLine2."Request Type" := Rec."Request Type";
                RequisitionLine2."Document No." := Rec."No.";
                RequisitionLine2."Line No." := LineNo;
                RequisitionLine2.Validate(Type, MaintenanceLine.Type);
                RequisitionLine2.Validate("No.", MaintenanceLine."No.");
                RequisitionLine2.Validate(Description, MaintenanceLine.Description);
                RequisitionLine2.Validate("Location Code", Rec."Location Code");
                RequisitionLine2.Validate("Unit of Measure Code", MaintenanceLine."Unit of Measure Code");
                RequisitionLine2.Validate(Quantity, MaintenanceLine.Quantity);
                RequisitionLine2.Validate("Direct Unit Cost", MaintenanceLine."Unit Cost");
                RequisitionLine2.Validate("Dimension Set ID", Rec."Dimension Set ID");
                RequisitionLine2.INSERT;

            until MaintenanceLine.next() = 0;
        end
    end;

    /// <summary>
    /// Description for ReqnLinesExist.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure ReqnLinesExist(): Boolean;
    begin
        ReqnLine.RESET;
        ReqnLine.SETRANGE("Document Type", "Document Type");
        ReqnLine.SETRANGE("Document No.", "No.");
        EXIT(ReqnLine.FINDFIRST);
    end;

    /// <summary>
    /// Description for RecreatePurchLines.
    /// </summary>
    /// <param name="ChangedFieldName">Parameter of type Text[100].</param>
    procedure RecreatePurchLines(ChangedFieldName: Text[100]);
    var
        ReqnLineTmp: Record "ADT Requisition Line" temporary;
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TempInteger: Record Integer temporary;
        ExtendedTextAdded: Boolean;
    begin
        IF ReqnLinesExist THEN BEGIN
            IF HideValidationDialog THEN
                Confirmed := TRUE
            ELSE
                Confirmed :=
                  CONFIRM(
                    Text016 +
                    Text004, FALSE, ChangedFieldName);
            IF Confirmed THEN BEGIN
                ReqnLine.LOCKTABLE;
                ItemChargeAssgntPurch.LOCKTABLE;
                MODIFY;

                ReqnLine.RESET;
                ReqnLine.SETRANGE("Document Type", "Document Type");
                ReqnLine.SETRANGE("Document No.", "No.");
                IF ReqnLine.FINDSET THEN BEGIN
                    REPEAT
                        ReqnLine.TESTFIELD("Quantity Received", 0);
                        ReqnLine.TESTFIELD("Quantity Invoiced", 0);
                        ReqnLine.TESTFIELD("Return Qty. Shipped", 0);
                        ReqnLine.CALCFIELDS("Reserved Qty. (Base)");
                        ReqnLine.TESTFIELD("Reserved Qty. (Base)", 0);
                        ReqnLine.TESTFIELD("Receipt No.", '');
                        ReqnLine.TESTFIELD("Return Shipment No.", '');
                        ReqnLine.TESTFIELD("Sales Order No.", '');
                        ReqnLine.TESTFIELD("Blanket Order No.", '');
                        ReqnLine.TESTFIELD("Prepmt. Amt. Inv.", 0);
                        ReqnLineTmp := ReqnLine;
                        IF ReqnLine.Nonstock THEN BEGIN
                            ReqnLine.Nonstock := FALSE;
                            ReqnLine.MODIFY;
                        END;
                        ReqnLineTmp.INSERT;
                    UNTIL ReqnLine.NEXT = 0;

                    ItemChargeAssgntPurch.SETRANGE("Document Type", "Document Type");
                    ItemChargeAssgntPurch.SETRANGE("Document No.", "No.");
                    IF ItemChargeAssgntPurch.FINDSET THEN BEGIN
                        REPEAT
                            TempItemChargeAssgntPurch.INIT;
                            TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                            TempItemChargeAssgntPurch.INSERT;
                        UNTIL ItemChargeAssgntPurch.NEXT = 0;
                        ItemChargeAssgntPurch.DELETEALL;
                    END;

                    ReqnLine.DELETEALL(TRUE);

                    ReqnLine.INIT;
                    ReqnLine."Line No." := 0;
                    ReqnLineTmp.FINDSET;
                    ExtendedTextAdded := FALSE;
                    REPEAT
                        IF ReqnLineTmp."Attached to Line No." = 0 THEN BEGIN
                            ReqnLine.INIT;
                            ReqnLine."Line No." := ReqnLine."Line No." + 10000;
                            ReqnLine.VALIDATE(Type, ReqnLineTmp.Type);
                            IF ReqnLineTmp."No." = '' THEN BEGIN
                                ReqnLine.VALIDATE(Description, ReqnLineTmp.Description);
                                ReqnLine.VALIDATE("Description 2", ReqnLineTmp."Description 2");
                            END ELSE BEGIN
                                ReqnLine.VALIDATE("No.", ReqnLineTmp."No.");
                                IF ReqnLine.Type <> ReqnLine.Type::" " THEN BEGIN
                                    ReqnLine.VALIDATE("Unit of Measure Code", ReqnLineTmp."Unit of Measure Code");
                                    ReqnLine.VALIDATE("Variant Code", ReqnLineTmp."Variant Code");
                                    IF (ReqnLineTmp."Job No." <> '') AND (ReqnLineTmp."Job Task No." <> '') THEN BEGIN
                                        ReqnLine.VALIDATE("Job No.", ReqnLineTmp."Job No.");
                                        ReqnLine.VALIDATE("Job Task No.", ReqnLineTmp."Job Task No.");
                                        ReqnLine."Job Line Type" := ReqnLineTmp."Job Line Type";
                                    END;
                                    IF ReqnLineTmp.Quantity <> 0 THEN
                                        ReqnLine.VALIDATE(Quantity, ReqnLineTmp.Quantity);
                                    ReqnLine."Sales Order No." := ReqnLineTmp."Sales Order No.";
                                    ReqnLine."Sales Order Line No." := ReqnLineTmp."Sales Order Line No.";
                                    ReqnLine."Drop Shipment" := ReqnLine."Sales Order Line No." <> 0;
                                    ReqnLine."Prod. Order No." := ReqnLineTmp."Prod. Order No.";
                                    ReqnLine."Routing No." := ReqnLineTmp."Routing No.";
                                    ReqnLine."Routing Reference No." := ReqnLineTmp."Routing Reference No.";
                                    ReqnLine."Operation No." := ReqnLineTmp."Operation No.";
                                    ReqnLine."Work Center No." := ReqnLineTmp."Work Center No.";
                                    ReqnLine."Prod. Order Line No." := ReqnLineTmp."Prod. Order Line No.";
                                    ReqnLine."Overhead Rate" := ReqnLineTmp."Overhead Rate";
                                END;
                            END;
                            ReqnLine.INSERT;
                            ExtendedTextAdded := FALSE;

                            IF ReqnLine.Type = ReqnLine.Type::Item THEN BEGIN
                                ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type", ReqnLineTmp."Document Type");
                                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.", ReqnLineTmp."Document No.");
                                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.", ReqnLineTmp."Line No.");
                                IF TempItemChargeAssgntPurch.FINDSET THEN BEGIN
                                    REPEAT
                                        IF NOT TempItemChargeAssgntPurch.MARK THEN BEGIN
                                            TempItemChargeAssgntPurch."Applies-to Doc. Line No." := ReqnLine."Line No.";
                                            TempItemChargeAssgntPurch.Description := ReqnLine.Description;
                                            TempItemChargeAssgntPurch.MODIFY;
                                            TempItemChargeAssgntPurch.MARK(TRUE);
                                        END;
                                    UNTIL TempItemChargeAssgntPurch.NEXT = 0;
                                END;
                            END;
                            IF ReqnLine.Type = ReqnLine.Type::"Charge (Item)" THEN BEGIN
                                TempInteger.INIT;
                                TempInteger.Number := ReqnLine."Line No.";
                                TempInteger.INSERT;
                            END;
                        END ELSE
                            IF NOT ExtendedTextAdded THEN BEGIN
                                ReqnLine.FINDLAST;
                                ExtendedTextAdded := TRUE;
                            END;
                    UNTIL ReqnLineTmp.NEXT = 0;

                    ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                    ReqnLineTmp.SETRANGE(Type, ReqnLine.Type::"Charge (Item)");
                    IF ReqnLineTmp.FINDSET THEN
                        REPEAT
                            TempItemChargeAssgntPurch.SETRANGE("Document Line No.", ReqnLineTmp."Line No.");
                            IF TempItemChargeAssgntPurch.FINDSET THEN BEGIN
                                REPEAT
                                    TempInteger.FINDFIRST;
                                    ItemChargeAssgntPurch.INIT;
                                    ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                                    ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                                    ItemChargeAssgntPurch.VALIDATE("Unit Cost", 0);
                                    ItemChargeAssgntPurch.INSERT;
                                UNTIL TempItemChargeAssgntPurch.NEXT = 0;
                                TempInteger.DELETE;
                            END;
                        UNTIL ReqnLineTmp.NEXT = 0;

                    ReqnLineTmp.SETRANGE(Type);
                    ReqnLineTmp.DELETEALL;
                    ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                    TempItemChargeAssgntPurch.DELETEALL;
                END;
            END ELSE
                ERROR(
                  Text018, ChangedFieldName);
        END;
    end;

    procedure MessageIfPurchLinesExist(ChangedFieldName: Text[100]);
    begin
        IF ReqnLinesExist AND NOT HideValidationDialog THEN
            MESSAGE(
              Text019 +
              Text020,
              ChangedFieldName);
    end;

    procedure PriceMessageIfPurchLinesExist(ChangedFieldName: Text[100]);
    begin
        IF ReqnLinesExist AND NOT HideValidationDialog THEN
            MESSAGE(
              Text019 +
              Text021, ChangedFieldName);
    end;

    local procedure UpdateCurrencyFactor();
    begin
        IF "Currency Code" <> '' THEN BEGIN
            IF ("Document Type" IN ["Document Type"::"Store Requisition"]) AND
               ("Posting Date" = 0D)
            THEN
                CurrencyDate := WORKDATE
            ELSE
                CurrencyDate := "Posting Date";

            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        END ELSE
            "Currency Factor" := 0;
    end;

    local procedure ConfirmUpdateCurrencyFactor();
    begin
        IF HideValidationDialog THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(Text022, FALSE);
        IF Confirmed THEN
            VALIDATE("Currency Factor")
        ELSE
            "Currency Factor" := xRec."Currency Factor";
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure UpdatePurchLines(ChangedFieldName: Text[100]);
    var
        UpdateConfirmed: Boolean;
    begin
        IF ReqnLinesExist THEN BEGIN

            IF NOT GUIALLOWED THEN
                UpdateConfirmed := TRUE
            ELSE
                CASE ChangedFieldName OF
                    FIELDCAPTION("Expected Receipt Date"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));
                    FIELDCAPTION("Requested Receipt Date"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));
                    FIELDCAPTION("Promised Receipt Date"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));
                    FIELDCAPTION("Lead Time Calculation"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));
                    FIELDCAPTION("Inbound Whse. Handling Time"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));
                    FIELDCAPTION("Prepayment %"):
                        UpdateConfirmed := CONFIRM(STRSUBSTNO(
                              Text032 +
                              Text033, ChangedFieldName));

                END;
            ReqnLine.LOCKTABLE;

            MODIFY;

            REPEAT
                xReqnLine := ReqnLine;
                CASE ChangedFieldName OF
                    FIELDCAPTION("Expected Receipt Date"):
                        IF UpdateConfirmed AND (ReqnLine."No." <> '') THEN
                            ReqnLine.VALIDATE("Expected Receipt Date", "Expected Receipt Date");
                    FIELDCAPTION("Currency Factor"):
                        IF ReqnLine.Type <> ReqnLine.Type::" " THEN
                            ReqnLine.VALIDATE("Direct Unit Cost");
                    FIELDCAPTION("Transaction Type"):
                        ReqnLine.VALIDATE("Transaction Type", "Transaction Type");
                    FIELDCAPTION("Transport Method"):
                        ReqnLine.VALIDATE("Transport Method", "Transport Method");
                    FIELDCAPTION("Entry Point"):
                        ReqnLine.VALIDATE("Entry Point", "Entry Point");
                    FIELDCAPTION(Area):
                        ReqnLine.VALIDATE(Area, Area);
                    FIELDCAPTION("Transaction Specification"):
                        ReqnLine.VALIDATE("Transaction Specification", "Transaction Specification");
                    FIELDCAPTION("Requested Receipt Date"):
                        IF UpdateConfirmed AND (ReqnLine."No." <> '') THEN
                            ReqnLine.VALIDATE("Requested Receipt Date", "Requested Receipt Date");
                    FIELDCAPTION("Prepayment %"):
                        IF ReqnLine."No." <> '' THEN
                            ReqnLine.VALIDATE("Prepayment %", "Prepayment %");
                    FIELDCAPTION("Promised Receipt Date"):
                        IF UpdateConfirmed AND (ReqnLine."No." <> '') THEN
                            ReqnLine.VALIDATE("Promised Receipt Date", "Promised Receipt Date");
                    FIELDCAPTION("Lead Time Calculation"):
                        IF UpdateConfirmed AND (ReqnLine."No." <> '') THEN
                            ReqnLine.VALIDATE("Lead Time Calculation", "Lead Time Calculation");
                    FIELDCAPTION("Inbound Whse. Handling Time"):
                        IF UpdateConfirmed AND (ReqnLine."No." <> '') THEN
                            ReqnLine.VALIDATE("Inbound Whse. Handling Time", "Inbound Whse. Handling Time");
                END;

                ReqnLine.MODIFY(TRUE);

            UNTIL ReqnLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// Description for ValidateShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Parameter of type Integer.</param>
    /// <param name="ShortcutDimCode">Parameter of type Code[20].</param>
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify;

        if OldDimSetID <> "Dimension Set ID" then begin
            if "No." <> '' then
                Modify;
            if PurchLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;

        OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    /// <summary>
    /// Description for ReceivedPurchLinesExist.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure "ReceivedPurchLinesExist`"(): Boolean;
    begin
        ReqnLine.RESET;
        ReqnLine.SETRANGE("Document Type", "Document Type");
        ReqnLine.SETRANGE("Document No.", "No.");
        ReqnLine.SETFILTER("Quantity Received", '<>0');
        EXIT(ReqnLine.FINDFIRST);
    end;

    /// <summary>
    /// Description for ReturnShipmentExist.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure ReturnShipmentExist(): Boolean;
    begin
        ReqnLine.RESET;
        ReqnLine.SETRANGE("Document Type", "Document Type");
        ReqnLine.SETRANGE("Document No.", "No.");
        ReqnLine.SETFILTER("Return Qty. Shipped", '<>0');
        EXIT(ReqnLine.FINDFIRST);
    end;

    /// <summary>
    /// Description for UpdateShipToAddress.
    /// </summary>
    local procedure UpdateShipToAddress();
    begin
        IF ("Location Code" <> '') AND
           Location.GET("Location Code") AND
           ("Sell-to Customer No." = '')
        THEN BEGIN
            "Ship-to Name" := Location.Name;
            "Ship-to Name 2" := Location."Name 2";
            "Ship-to Address" := Location.Address;
            "Ship-to Address 2" := Location."Address 2";
            "Ship-to City" := Location.City;
            "Ship-to Post Code" := Location."Post Code";
            "Ship-to County" := Location.County;
            "Ship-to Country/Region Code" := Location."Country/Region Code";
            "Ship-to Contact" := Location.Contact;
        END;

        IF ("Location Code" = '') AND
           ("Sell-to Customer No." = '')
        THEN BEGIN
            CompanyInfo.GET;
            "Ship-to Code" := '';
            "Ship-to Name" := CompanyInfo."Ship-to Name";
            "Ship-to Name 2" := CompanyInfo."Ship-to Name 2";
            "Ship-to Address" := CompanyInfo."Ship-to Address";
            "Ship-to Address 2" := CompanyInfo."Ship-to Address 2";
            "Ship-to City" := CompanyInfo."Ship-to City";
            "Ship-to Post Code" := CompanyInfo."Ship-to Post Code";
            "Ship-to County" := CompanyInfo."Ship-to County";
            "Ship-to Country/Region Code" := CompanyInfo."Ship-to Country/Region Code";
            "Ship-to Contact" := CompanyInfo."Ship-to Contact";
        END;
    end;

    /// <summary>
    /// Description for DeletePurchaseLines.
    /// </summary>
    local procedure DeletePurchaseLines();
    begin
        IF ReqnLine.FINDSET THEN BEGIN
            HandleItemTrackingDeletion;
            REPEAT
                ReqnLine.SuspendStatusCheck(TRUE);
                ReqnLine.DELETE(TRUE);
            UNTIL ReqnLine.NEXT = 0;
        END;
    end;

    /// <summary>
    /// Description for HandleItemTrackingDeletion.
    /// </summary>
    procedure HandleItemTrackingDeletion();
    var
        ReserveEntry: Record "Reservation Entry";
        ReserveEntry2: Record "Reservation Entry";
    begin
        WITH ReserveEntry DO BEGIN
            RESET;
            SETCURRENTKEY(
              "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
              "Source Batch Name", "Source Prod. Order Line", "Reservation Status");
            SETRANGE("Source Type", DATABASE::"ADT Requisition Line");
            SETRANGE("Source Subtype", "Document Type");
            SETRANGE("Source ID", "No.");
            SETRANGE("Source Batch Name", '');
            SETRANGE("Source Prod. Order Line", 0);
            SETFILTER("Item Tracking", '> %1', "Item Tracking"::None);
            IF ISEMPTY THEN
                EXIT;

            IF HideValidationDialog OR NOT GUIALLOWED THEN
                Confirmed := TRUE
            ELSE
                Confirmed := CONFIRM(Text041, FALSE, LOWERCASE(FORMAT("Document Type")), "No.");

            IF NOT Confirmed THEN
                ERROR('');

            IF FINDSET THEN
                REPEAT
                    ReserveEntry2 := ReserveEntry;
                    ReserveEntry2.ClearItemTrackingFields;
                    ReserveEntry2.MODIFY;
                UNTIL NEXT = 0;
        END;
    end;


    local procedure ClearItemAssgntPurchFilter(var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)");
    begin
        TempItemChargeAssgntPurch.SETRANGE("Document Line No.");
        TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type");
        TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.");
        TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.");
    end;

    /// <summary>
    /// Description for UpdateBuyFromCont.
    /// </summary>
    /// <param name="VendorNo">Parameter of type Code[20].</param>
    procedure UpdateBuyFromCont(VendorNo: Code[20]);
    var
        ContBusRel: Record "Contact Business Relation";
        Vend: Record Vendor;
    begin
        IF Vend.GET(VendorNo) THEN BEGIN
            IF Vend."Primary Contact No." <> '' THEN
                "Buy-from Contact No." := Vend."Primary Contact No."
            ELSE BEGIN
                ContBusRel.RESET;
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Vendor);
                ContBusRel.SETRANGE("No.", "Buy-from Vendor No.");
                IF ContBusRel.FINDFIRST THEN
                    "Buy-from Contact No." := ContBusRel."Contact No."
                ELSE
                    "Buy-from Contact No." := '';
            END;
            "Buy-from Contact" := Vend.Contact;
        END;
    end;

    /// <summary>
    /// Description for UpdatePayToCont.
    /// </summary>
    /// <param name="VendorNo">Parameter of type Code[20].</param>
    procedure UpdatePayToCont(VendorNo: Code[20]);
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record "Contact";
        Vend: Record Vendor;
    begin
        IF Vend.GET(VendorNo) THEN BEGIN
            IF Vend."Primary Contact No." <> '' THEN
                "Pay-to Contact No." := Vend."Primary Contact No."
            ELSE BEGIN
                ContBusRel.RESET;
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Vendor);
                ContBusRel.SETRANGE("No.", "Pay-to Vendor No.");
                IF ContBusRel.FINDFIRST THEN
                    "Pay-to Contact No." := ContBusRel."Contact No."
                ELSE
                    "Pay-to Contact No." := '';
            END;
            "Pay-to Contact" := Vend.Contact;
        END;
    end;

    /// <summary>
    /// Description for UpdateBuyFromVend.
    /// </summary>
    /// <param name="ContactNo">Parameter of type Code[20].</param>
    procedure UpdateBuyFromVend(ContactNo: Code[20]);
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
    begin
        IF Cont.GET(ContactNo) THEN BEGIN
            "Buy-from Contact No." := Cont."No.";
            IF Cont.Type = Cont.Type::Person THEN
                "Buy-from Contact" := Cont.Name
            ELSE
                IF Vend.GET("Buy-from Vendor No.") THEN
                    "Buy-from Contact" := Vend.Contact
                ELSE
                    "Buy-from Contact" := ''
        END ELSE BEGIN
            "Buy-from Contact" := '';
            EXIT;
        END;

        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "Contact No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF ("Buy-from Vendor No." <> '') AND
               ("Buy-from Vendor No." <> ContBusinessRelation."No.")
            THEN
                ERROR(Text037, Cont."No.", Cont.Name, "Buy-from Vendor No.")
            ELSE
                IF "Buy-from Vendor No." = '' THEN BEGIN
                    SkipBuyFromContact := TRUE;
                    VALIDATE("Buy-from Vendor No.", ContBusinessRelation."No.");
                    SkipBuyFromContact := FALSE;
                END;
        END ELSE
            ERROR(Text039, Cont."No.", Cont.Name);

        IF ("Buy-from Vendor No." = "Pay-to Vendor No.") OR
           ("Pay-to Vendor No." = '')
        THEN
            VALIDATE("Pay-to Contact No.", "Buy-from Contact No.");
    end;

    /// <summary>
    /// Description for UpdatePayToVend.
    /// </summary>
    /// <param name="ContactNo">Parameter of type Code[20].</param>
    procedure UpdatePayToVend(ContactNo: Code[20]);
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
    begin
        IF Cont.GET(ContactNo) THEN BEGIN
            "Pay-to Contact No." := Cont."No.";
            IF Cont.Type = Cont.Type::Person THEN
                "Pay-to Contact" := Cont.Name
            ELSE
                IF Vend.GET("Pay-to Vendor No.") THEN
                    "Pay-to Contact" := Vend.Contact
                ELSE
                    "Pay-to Contact" := '';
        END ELSE BEGIN
            "Pay-to Contact" := '';
            EXIT;
        END;

        ContBusinessRelation.RESET;
        ContBusinessRelation.SETCURRENTKEY("Link to Table", "Contact No.");
        ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Vendor);
        ContBusinessRelation.SETRANGE("Contact No.", Cont."Company No.");
        IF ContBusinessRelation.FINDFIRST THEN BEGIN
            IF "Pay-to Vendor No." = '' THEN BEGIN
                SkipPayToContact := TRUE;
                VALIDATE("Pay-to Vendor No.", ContBusinessRelation."No.");
                SkipPayToContact := FALSE;
            END ELSE
                IF "Pay-to Vendor No." <> ContBusinessRelation."No." THEN
                    ERROR(Text037, Cont."No.", Cont.Name, "Pay-to Vendor No.");
        END ELSE
            ERROR(Text039, Cont."No.", Cont.Name);
    end;

    /// <summary>
    /// Description for CreateInvtPutAwayPick.
    /// </summary>
    procedure CreateInvtPutAwayPick();
    var
        WhseRequest: Record "Warehouse Request";
    begin
        TESTFIELD(Status, Status::Released);

        WhseRequest.RESET;
        WhseRequest.SETCURRENTKEY("Source Document", "Source No.");
        CASE "Document Type" OF
            "Document Type"::"Purchase Requisition":
                WhseRequest.SETRANGE("Source Document", WhseRequest."Source Document"::"Purchase Order");
        END;
        WhseRequest.SETRANGE("Source No.", "No.");
        REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt", TRUE, FALSE, WhseRequest);
    end;

    /// <summary>
    /// Description for ShowDocDim.
    /// </summary>
    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
        CustomFunctionsAndEVents: Codeunit "Fleet Management";
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          CustomFunctionsAndEVents.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Document Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF PurchLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    /// <summary>
    /// Description for SetAmountToApply.
    /// </summary>
    /// <param name="AppliesToDocNo">Parameter of type Code[20].</param>
    /// <param name="VendorNo">Parameter of type Code[20].</param>
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20]);
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.", AppliesToDocNo);
        VendLedgEntry.SETRANGE("Vendor No.", VendorNo);
        VendLedgEntry.SETRANGE(Open, TRUE);
        IF VendLedgEntry.FINDFIRST THEN BEGIN
            IF VendLedgEntry."Amount to Apply" = 0 THEN BEGIN
                VendLedgEntry.CALCFIELDS("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            END ELSE
                VendLedgEntry."Amount to Apply" := 0;
            CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        END;
    end;

    /// <summary>
    /// Description for SetShipToForSpecOrder.
    /// </summary>
    procedure SetShipToForSpecOrder();
    begin
        IF Location.GET("Location Code") THEN BEGIN
            "Ship-to Code" := '';
            "Ship-to Name" := Location.Name;
            "Ship-to Name 2" := Location."Name 2";
            "Ship-to Address" := Location.Address;
            "Ship-to Address 2" := Location."Address 2";
            "Ship-to City" := Location.City;
            "Ship-to Post Code" := Location."Post Code";
            "Ship-to County" := Location.County;
            "Ship-to Country/Region Code" := Location."Country/Region Code";
            "Ship-to Contact" := Location.Contact;
            "Location Code" := Location.Code;
        END ELSE BEGIN
            CompanyInfo.GET;
            "Ship-to Code" := '';
            "Ship-to Name" := CompanyInfo."Ship-to Name";
            "Ship-to Name 2" := CompanyInfo."Ship-to Name 2";
            "Ship-to Address" := CompanyInfo."Ship-to Address";
            "Ship-to Address 2" := CompanyInfo."Ship-to Address 2";
            "Ship-to City" := CompanyInfo."Ship-to City";
            "Ship-to Post Code" := CompanyInfo."Ship-to Post Code";
            "Ship-to County" := CompanyInfo."Ship-to County";
            "Ship-to Country/Region Code" := CompanyInfo."Ship-to Country/Region Code";
            "Ship-to Contact" := CompanyInfo."Ship-to Contact";
            "Location Code" := '';
        END;
    end;

    /// <summary>
    /// Description for JobUpdatePurchLines.
    /// </summary>
    procedure JobUpdatePurchLines();
    begin
        WITH ReqnLine DO BEGIN
            SETFILTER("Job No.", '<>%1', '');
            SETFILTER("Job Task No.", '<>%1', '');
            LOCKTABLE;
            IF FIND('-') THEN BEGIN
                REPEAT
                    JobSetCurrencyFactor;
                    VALIDATE(Quantity);
                    MODIFY;
                UNTIL NEXT = 0;
            END;
        END
    end;

    /// <summary>
    /// Description for GetPstdDocLinesToRevere.
    /// </summary>
    procedure GetPstdDocLinesToRevere();
    var
        PurchPostedDocLines: Page "Posted Purchase Document Lines";
    begin
        GetVend("Buy-from Vendor No.");
        PurchPostedDocLines.SETRECORD(Vend);
        PurchPostedDocLines.LOOKUPMODE := TRUE;
        IF PurchPostedDocLines.RUNMODAL = ACTION::LookupOK THEN
            CLEAR(PurchPostedDocLines);
    end;

    /// <summary>
    /// Description for UpdateValidityDate.
    /// </summary>
    procedure UpdateValidityDate();
    var
        FleetManagementSetup: Record "Fleet Management Setup";
    begin
        FleetManagementSetup.GET;
        IF "Document Type" = "Document Type"::"Store Requisition" THEN BEGIN
            IF FORMAT(FleetManagementSetup."Store Req. Validity Period") <> '' THEN
                "Valid to Date" := CALCDATE(FleetManagementSetup."Store Req. Validity Period", "Document Date");
        END
        ELSE
            IF "Document Type" = "Document Type"::"Purchase Requisition" THEN BEGIN
                IF FORMAT(FleetManagementSetup."Purch. Req. Validity Period") <> '' THEN
                    "Valid to Date" := CALCDATE(FleetManagementSetup."Purch. Req. Validity Period", "Document Date");
            END;
    end;

    /// <summary>
    /// Description for CalcBudgetAndAmount.
    /// </summary>
    /// <param name="NFL Req. Header No.">Parameter of type Code[10].</param>
    procedure CalcBudgetAndAmount("NFL Req. Header No.": Code[10]);
    begin
    end;

    /// <summary>
    /// Description for LookupShortcutDimCode.
    /// </summary>
    /// <param name="FieldNumber">Parameter of type Integer.</param>
    /// <param name="ShortcutDimCode">Parameter of type Code[20].</param>
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    /// <summary>
    /// Description for ShowShortcutDimCode.
    /// </summary>
    /// <param name="ShortcutDimCode">Parameter of type array[8] of Code[20].</param>
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    /// <summary>
    /// Description for PurchLinesExist.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure PurchLinesExist(): Boolean;
    begin
        NFLPurchLine.RESET;
        NFLPurchLine.SETRANGE("Document Type", "Document Type");
        NFLPurchLine.SETRANGE("Document No.", "No.");
        EXIT(NFLPurchLine.FINDFIRST);
    end;

    /// <summary>
    /// Description for UpdateAllLineDim.
    /// </summary>
    /// <param name="NewParentDimSetID">Parameter of type Integer.</param>
    /// <param name="OldParentDimSetID">Parameter of type Integer.</param>
    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
    begin
        // Update all lines with changed dimensions.
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM('You may have changed a dimension.\\Do you want to update the lines?') THEN
            EXIT;

        NFLPurchLine.RESET;
        NFLPurchLine.SETRANGE("Document Type", "Document Type");
        NFLPurchLine.SETRANGE("Document No.", "No.");
        NFLPurchLine.LOCKTABLE;
        IF NFLPurchLine.FIND('-') THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(NFLPurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF NFLPurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    NFLPurchLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      NFLPurchLine."Dimension Set ID", NFLPurchLine."Shortcut Dimension 1 Code", NFLPurchLine."Shortcut Dimension 2 Code");
                    NFLPurchLine.MODIFY;
                END;
            UNTIL NFLPurchLine.NEXT = 0;
    end;

    /// <summary>
    /// Description for UpdateAllLineBudget.
    /// </summary>
    /// <param name="BudgetCode">Parameter of type Code[10].</param>
    local procedure UpdateAllLineBudget(BudgetCode: Code[10]);
    var
        NewBudgetCode: Code[10];
        lvNFLRequisitionLine: Record "ADT Requisition Line";
    begin
        // Update all lines with changed budget code.

        lvNFLRequisitionLine.RESET;
        lvNFLRequisitionLine.SETRANGE("Document No.", "No.");
        lvNFLRequisitionLine.LOCKTABLE;
        IF lvNFLRequisitionLine.FIND('-') THEN
            REPEAT
                lvNFLRequisitionLine."Budget Code" := BudgetCode;
                lvNFLRequisitionLine."Accounting Period Start Date" := "Accounting Period Start Date";
                lvNFLRequisitionLine."Accounting Period End Date" := "Accounting Period End Date";

                lvNFLRequisitionLine."Fiscal Year Start Date" := "Fiscal Year Start Date";
                lvNFLRequisitionLine."Fiscal Year End Date" := "Fiscal Year End Date";

                lvNFLRequisitionLine."Filter to Date Start Date" := "Filter to Date Start Date";
                lvNFLRequisitionLine."Filter to Date End Date" := "Filter to Date End Date";

                lvNFLRequisitionLine."Quarter Start Date" := "Quarter Start Date";
                lvNFLRequisitionLine."Quarter End Date" := "Quarter End Date";

                lvNFLRequisitionLine.MODIFY;
            UNTIL lvNFLRequisitionLine.NEXT = 0;
    end;

    /// <summary>
    /// Description for GetFiscalYearAndAccountingPeriod.
    /// </summary>
    /// <param name="parDate">Parameter of type Date.</param>
    local procedure GetFiscalYearAndAccountingPeriod(var parDate: Date);
    var
        lvAccountingPeriod: Record "Accounting Period";
        lvAccountingPeriod2: Record "Accounting Period";
        lvStartingDate: Date;
        lvEndingDate: Date;
        NewDate: Date;
        lvFiscalYearStartingDate: Date;
        lvFiscalYearEndingDate: Date;
        lvFound: Boolean;
        lvQtrOneStartDate: Date;
        lvQtrTwoStartDate: Date;
        lvQtrThreeStartDate: Date;
        lvQtrFourStartDate: Date;
        DateStart: Date;
        DateEnd: Date;
        lvQtrStartDate: Date;
        lvQtrEndDate: Date;
        lvQtrFound: Boolean;
    begin

        lvStartingDate := DMY2DATE(1, DATE2DMY(parDate, 2), DATE2DMY(parDate, 3));
        lvEndingDate := CALCDATE('<CM>', parDate);
        VALIDATE("Accounting Period Start Date", lvStartingDate);
        VALIDATE("Accounting Period End Date", lvEndingDate);

        // Get Fiscal Year Start Date basing on the posting date entered.
        lvAccountingPeriod2.SETFILTER("Starting Date", '<=%1', lvStartingDate);
        IF lvAccountingPeriod2.FIND('-') THEN BEGIN
            REPEAT
                IF lvAccountingPeriod2."New Fiscal Year" = TRUE THEN BEGIN
                    lvFiscalYearStartingDate := lvAccountingPeriod2."Starting Date";
                END;
            UNTIL lvAccountingPeriod2.NEXT = 0;
        END ELSE
            ERROR('There is no accounting period in the selected posting date');


        // Get Fiscal Year End Date basing on the posting date entered.
        lvAccountingPeriod.SETFILTER("Starting Date", '>=%1', lvStartingDate);
        IF lvAccountingPeriod.FIND('-') THEN BEGIN
            REPEAT
                // The second condition prevents from having a fiscal year of one month. e.g. if the specified date falls in the month of July
                IF (lvAccountingPeriod."New Fiscal Year" = TRUE)
                AND (lvAccountingPeriod."Starting Date" <> lvFiscalYearStartingDate)
                THEN BEGIN
                    lvFiscalYearEndingDate := CALCDATE('-1D', lvAccountingPeriod."Starting Date"); // end of the previous month.
                    lvFound := TRUE;
                END;
            UNTIL lvFound OR (lvAccountingPeriod.NEXT = 0);
        END ELSE
            ERROR('There is no accounting period in the selected posting date');

        VALIDATE("Filter to Date Start Date", lvFiscalYearStartingDate);
        VALIDATE("Filter to Date End Date", parDate);

        VALIDATE("Fiscal Year Start Date", lvFiscalYearStartingDate);
        VALIDATE("Fiscal Year End Date", lvFiscalYearEndingDate);

        // Get Quarter in which a date falls.
        DateStart := lvFiscalYearStartingDate;
        DateEnd := lvFiscalYearEndingDate;

        // Loop all Quarters and find where the posting date falls.
        WHILE (DateStart < DateEnd) AND (lvQtrFound = FALSE) DO BEGIN
            IF (parDate >= DateStart) AND (parDate <= CALCDATE('3M', DateStart)) THEN BEGIN
                lvQtrStartDate := DateStart;
                lvQtrEndDate := CALCDATE('3M', DateStart);
                lvQtrEndDate := CALCDATE('-1D', lvQtrEndDate);
                VALIDATE("Quarter Start Date", lvQtrStartDate);
                VALIDATE("Quarter End Date", lvQtrEndDate);
                lvQtrFound := TRUE;
            END;
            DateStart := CALCDATE('3M', DateStart);
        END;
    end;

    local procedure UpdateAllLineDateFilters(PostingDate: Date);
    var
        NewBudgetCode: Code[10];
        lvNFLRequisitionLine: Record "ADT Requisition Line";
    begin
        // Update all lines with changed budget code.
        lvNFLRequisitionLine.RESET;
        lvNFLRequisitionLine.SETRANGE("Document No.", "No.");
        lvNFLRequisitionLine.LOCKTABLE;
        IF lvNFLRequisitionLine.FIND('-') THEN
            REPEAT
                GetFiscalYearAndAccountingPeriod(PostingDate);
                lvNFLRequisitionLine."Accounting Period Start Date" := "Accounting Period Start Date"; // Month in which the posting date falls.
                lvNFLRequisitionLine."Accounting Period End Date" := "Accounting Period End Date";
                lvNFLRequisitionLine."Fiscal Year Start Date" := "Fiscal Year Start Date";    // Fiscal Year
                lvNFLRequisitionLine."Fiscal Year End Date" := "Fiscal Year End Date";
                lvNFLRequisitionLine."Filter to Date Start Date" := "Filter to Date Start Date";   // From Start of Fiscal Year to the Posting Date
                lvNFLRequisitionLine."Filter to Date End Date" := "Filter to Date End Date";
                lvNFLRequisitionLine."Quarter Start Date" := "Quarter Start Date"; // Quarter in which the posting date falls.
                lvNFLRequisitionLine."Quarter End Date" := "Quarter End Date";
                lvNFLRequisitionLine.VALIDATE("Accounting Period Start Date");
                lvNFLRequisitionLine.VALIDATE("Accounting Period End Date");
                lvNFLRequisitionLine.VALIDATE("Filter to Date Start Date");
                lvNFLRequisitionLine.VALIDATE("Filter to Date End Date");
                lvNFLRequisitionLine.VALIDATE("Fiscal Year Start Date");
                lvNFLRequisitionLine.VALIDATE("Fiscal Year End Date");
                lvNFLRequisitionLine.VALIDATE("Quarter Start Date");
                lvNFLRequisitionLine.VALIDATE("Quarter End Date");
                lvNFLRequisitionLine.MODIFY;
            UNTIL lvNFLRequisitionLine.NEXT = 0;
    end;

    /// <summary>
    /// Description for StorePurchDocument.
    /// </summary>
    /// <param name="PurchHeader">Parameter of type Record "ADT Requisition Header".</param>
    /// <param name="InteractionExist">Parameter of type Boolean.</param>
    procedure StorePurchDocument(var PurchHeader: Record "ADT Requisition Header");
    begin
        PurchHeader.TestField("Converted to Order", true);
        PurchHeader.TestField(Committed, true);
        PurchHeader.Validate(Archived, true);
        PurchHeader.Modify();
        Message('Purchase Requisition %1 has been archived Successfully.', PurchHeader."No.");
    end;

    procedure ArchiveStoreRequisition()
    var
        StoreLines: Record "ADT Requisition Line";
        AllTransfered: Boolean;
    begin
        AllTransfered := true;
        Rec.TestField(Status, Rec.Status::Released);
        if Rec.Transferred = true then begin
            Rec.Archived := true;
            Rec.Modify();
        end else begin
            StoreLines.Reset();
            StoreLines.SetRange("Document No.", Rec."No.");
            StoreLines.SetRange("Document Type", Rec."Document Type");
            if StoreLines.FindFirst() then
                repeat
                    if ((StoreLines."Transferred To Item Jnl" = false) and (StoreLines."Transferred to Job Jnl" = false)) then
                        AllTransfered := false;
                    if AllTransfered = false then
                        exit;
                until StoreLines.Next() = 0;

            if AllTransfered then begin
                Rec.Transferred := true;
                Rec.Archived := true;
                Rec.Modify();
            end;
        end;
    end;

    /// <summary>
    /// Description for GetNextVersionNo.
    /// </summary>
    /// <param name="TableId">Parameter of type Integer.</param>
    /// <param name="DocType">Parameter of type Option "Store Requisition","Purchase Requisition".</param>
    /// <param name="DocNo">Parameter of type Code[20].</param>
    /// <param name="DocNoOccurrence">Parameter of type Integer.</param>
    /// <returns>Return variable "Integer".</returns>
    procedure GetNextVersionNo(TableId: Integer; DocType: Option "Store Requisition","Purchase Requisition"; DocNo: Code[20]; DocNoOccurrence: Integer): Integer;
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        CASE TableId OF
            DATABASE::"Sales Header":
                BEGIN
                    SalesHeaderArchive.LOCKTABLE;
                    SalesHeaderArchive.SETRANGE("Document Type", DocType);
                    SalesHeaderArchive.SETRANGE("No.", DocNo);
                    SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
                    IF SalesHeaderArchive.FINDLAST THEN
                        EXIT(SalesHeaderArchive."Version No." + 1)
                    ELSE
                        EXIT(1);
                END;
            DATABASE::"ADT Requisition Header":
                BEGIN
                END;
        END;
    end;

    /// <summary>
    /// GetNextVersionNomodified.
    /// </summary>
    /// <param name="TableId">Integer.</param>
    /// <param name="DocType">Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order".</param>
    /// <param name="DocNo">Code[20].</param>
    /// <param name="DocNoOccurrence">Integer.</param>
    /// <returns>Return variable VersionNo of type Integer.</returns>
    procedure GetNextVersionNomodified(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; DocNoOccurrence: Integer) VersionNo: Integer
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        case TableId of
            DATABASE::"Sales Header":
                begin
                    SalesHeaderArchive.LockTable();
                    SalesHeaderArchive.SetRange("Document Type", DocType);
                    SalesHeaderArchive.SetRange("No.", DocNo);
                    SalesHeaderArchive.SetRange("Doc. No. Occurrence", DocNoOccurrence);
                    if SalesHeaderArchive.FindLast then
                        exit(SalesHeaderArchive."Version No." + 1);

                    exit(1);
                end;
            DATABASE::"ADT Requisition Header":
                begin
                end;
            else begin
                OnGetNextVersionNo(TableId, DocType, DocNo, DocNoOccurrence, VersionNo);
                exit(VersionNo)
            end;
        end;
    end;

    /// <summary>
    /// Description for StorePurchDocumentComments.
    /// </summary>
    /// <param name="DocType">Parameter of type Option.</param>
    /// <param name="DocNo">Parameter of type Code[20].</param>
    /// <param name="DocNoOccurrence">Parameter of type Integer.</param>
    /// <param name="VersionNo">Parameter of type Integer.</param>
    local procedure StorePurchDocumentComments(DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; VersionNo: Integer);
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentLineArch: Record "Purch. Comment Line Archive";
    begin
        IF DocType = 1 THEN
            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Return Shipment");

        IF DocType = 0 THEN
            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Credit Memo");

        PurchCommentLine.SETRANGE("No.", DocNo);
        IF PurchCommentLine.FINDSET THEN
            REPEAT
                PurchCommentLineArch.INIT;
                PurchCommentLineArch.TRANSFERFIELDS(PurchCommentLine);
                PurchCommentLineArch."Doc. No. Occurrence" := DocNoOccurrence;
                PurchCommentLineArch."Version No." := VersionNo;
                PurchCommentLineArch.INSERT;
            UNTIL PurchCommentLine.NEXT = 0;
    end;

    /// <summary>
    /// CheckBudget.
    /// </summary>
    procedure CheckBudget();
    begin
        TESTFIELD(Rec."Budget Code");
        TESTFIELD(Rec."Shortcut Dimension 1 Code");
    end;

    //New functionss
    /// <summary>
    /// CreateDimFromDefaultDim.
    /// </summary>
    /// <param name="FieldNo">Integer.</param>
    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::Vendor, Rec."Pay-to Vendor No.", FieldNo = Rec.FieldNo("Pay-to Vendor No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Salesperson/Purchaser", Rec."Purchaser Code", FieldNo = Rec.FieldNo("Purchaser Code"));
        DimMgt.AddDimSource(DefaultDimSource, Database::Campaign, Rec."Campaign No.", FieldNo = Rec.FieldNo("Campaign No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));
    end;

    /// <summary>
    /// CreateDim.
    /// </summary>
    /// <param name="DefaultDimSource">List of [Dictionary of [Integer, Code[20]]].</param>
    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        SourceCodeSetup.Get();

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Purchases, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        if (OldDimSetID <> "Dimension Set ID") and (OldDimSetID <> 0) and guiallowed then
            if CouldDimensionsBeKept() then
                if ConfirmKeepExistingDimensions(OldDimSetID) then begin
                    "Dimension Set ID" := OldDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(Rec."Dimension Set ID", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code");
                end;

        if (OldDimSetID <> "Dimension Set ID") and PurchLinesExist() then begin
            Modify();
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure CouldDimensionsBeKept() Result: Boolean;
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then begin
            if CurrFieldNo = 0 then
                exit(false);
            if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> Rec."Buy-from Vendor No.") then
                exit(false);
            if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> Rec."Pay-to Vendor No.") then
                exit(false);
            if (Rec."Location Code" = '') and (xRec."Location Code" <> '') then
                exit(true);
            if (xRec."location Code" <> Rec."Location Code") then
                exit(true);
            if (xRec."Purchaser Code" <> '') and (xRec."Purchaser Code" <> Rec."Purchaser Code") then
                exit(true);
            if (xRec."Responsibility Center" <> '') and (xRec."Responsibility Center" <> Rec."Responsibility Center") then
                exit(true);
            if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> Rec."Sell-to Customer No.") then
                exit(true);
        end;
    end;

    local procedure ConfirmKeepExistingDimensions(OldDimSetID: Integer) Confirmed: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Confirmed);

        Confirmed := Confirm(DoYouWantToKeepExistingDimensionsQst);
    end;

    //================================Approval=========================================

    /// <summary>
    /// PerformManualReopen.
    /// </summary>
    /// <param name="VAR NFLRequisitionHeader">Record "ADT Requisition Header".</param>
    procedure PerformManualReopen(VAR NFLRequisitionHeader: Record "ADT Requisition Header")
    var
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        VoucherAdmin := false;

        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then begin
            VoucherAdmin := true;
        end;
        if (VoucherAdmin = true) then begin
            IF NFLRequisitionHeader.Status = NFLRequisitionHeader.Status::"Pending Approval" THEN
                ERROR('You Can not open a document Pending Approval');
            Reopen(NFLRequisitionHeader);
        end else begin
            Error('Your not allowed to perfom this Operation, Document can only be opened by Voucher Admin');
        end;
    end;

    /// <summary>
    /// Reopen.
    /// </summary>
    /// <param name="VAR NFLRequisitionHeader">Record "ADT Requisition Header".</param>
    procedure Reopen(VAR NFLRequisitionHeader: Record "ADT Requisition Header")
    begin
        WITH NFLRequisitionHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            Status := Status::Open;
            MODIFY(TRUE);
            Message('The Document has been Reopened Successfully');
        END;
    end;


    /// <summary>
    /// ReleaseTheApprovedDoc.
    /// </summary>
    procedure ReleaseTheApprovedDoc()
    var
        NvText: Label 'The approval Request has been Approved';
        PurchaseRequisition: Record "ADT Requisition Header";
    begin
        CalcFields("Approvals Entry");
        if "Approvals Entry" = 0 then begin
            if Rec.Status = Rec.Status::"Pending approval" then begin
                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."No.");
                if PurchaseRequisition.FindFirst() then begin
                    PurchaseRequisition.Status := PurchaseRequisition.Status::Released;
                    PurchaseRequisition."Release date" := Today();
                    PurchaseRequisition.Modify();
                end;
            end;
            Message(NvText);
        end;
    end;

    //check he document release
    /// <summary>
    /// CheckDocumentRelease.
    /// </summary>
    /// <param name="PurchaseRequisition">VAR Record "ADT Requisition Header".</param>
    procedure CheckDocumentRelease(var PurchaseRequisition: Record "ADT Requisition Header")
    var
        ApprovalEntries: Record "Approval Entry";
        PurchaseSetup: Record "Purchases & Payables Setup";
        NotReleased: Boolean;
        countNumber: Integer;
    begin
        NotReleased := false;
        countNumber := 0;

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", PurchaseRequisition."No.");
        if ApprovalEntries.FindFirst() then begin
            repeat
                if (ApprovalEntries.Status = ApprovalEntries.Status::Open) or (ApprovalEntries.Status = ApprovalEntries.Status::Created) then
                    NotReleased := true;
                countNumber += 1;
            until ApprovalEntries.Next() = 0;
        end;

        if (countNumber > 0) and (NotReleased = false) then
            Rec.SendReleaseEmail(PurchaseRequisition);
    end;

    /// <summary>
    /// SendingCancelApprovalEmail.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    procedure SendingCancelApprovalEmail(RequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin

    end;

    /// <summary>
    /// SendRequisitionApprovedEmail.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    procedure SendRequisitionApprovedEmail(RequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", RequisitionHeader."No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendEmailToVoucherOwner(RequisitionHeader, ApprovalEntry);
            SendEmailToVoucherApprover(RequisitionHeader, ApprovalEntry);
        end;
    end;

    /// <summary>
    /// SendEmailToVoucherOwner.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    /// <param name="ApprovalEntry">Record "Approval Entry".</param>
    procedure SendEmailToVoucherOwner(RequisitionHeader: Record "ADT Requisition Header"; ApprovalEntry: Record "Approval Entry")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Sender ID") then begin
            if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then begin
                EmailSubject := 'Fuel Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Fuel Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end
            else if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then begin
                EmailSubject := 'Spare Parts Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Spare Parts Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end
            else begin
                EmailSubject := 'Spare Parts Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end;

            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    /// <summary>
    /// SendEmailToVoucherApprover.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    /// <param name="ApprovalEntry">Record "Approval Entry".</param>
    procedure SendEmailToVoucherApprover(RequisitionHeader: Record "ADT Requisition Header"; ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEmailSubject: Text[150];
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Approver ID") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>' + 'Requisition No. ' + ApprovalEntry."Document No." + ' is on your desk for approval ' + 'https://dynamics365.bcc.co.ug/BC230/?company=Blue%20Crane%20Communications&page=654';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'Requisition: ' + DocumentNo + ' Requires Your attension';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    /// <summary>
    /// SendReleaseEmail.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    procedure SendReleaseEmail(RequisitionHeader: Record "ADT Requisition Header")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(RequisitionHeader."Prepared by") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + ', Purchase Requisition No. ' + RequisitionHeader."No." + ' has been Approved/Released.';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := RequisitionHeader."No.";
            EmailSubject := 'Purchase Requisition ' + DocumentNo + ' has been approved.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            false, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    /// <summary>
    /// SendRejectEmail.
    /// </summary>
    /// <param name="RequisitionHeader">Record "ADT Requisition Header".</param>
    procedure SendRejectEmail(RequisitionHeader: Record "ADT Requisition Header")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
        RejectComment: Text[1000];
        SalesCommentLine: Record "Sales Comment Line";
    begin
        if UserSetup.Get(RequisitionHeader."Prepared by") then begin
            SalesCommentLine.Reset();
            SalesCommentLine.SetRange("No.", RequisitionHeader."No.");
            SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Purchase Requisition");
            if SalesCommentLine.FindLast() then
                RejectComment := SalesCommentLine.Comment;

            EmailBody := 'Dear ' + UserSetup."E-Mail" + ', Purchase Requisition No. ' + RequisitionHeader."No." + ' has been Rejected by ' + UserId + ' because "' + RejectComment + '"';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := RequisitionHeader."No.";
            EmailSubject := 'Purchase Requisition ' + DocumentNo + ' has been Rejected.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            false, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure PurchaseRequisitionDelegate(var PurchaseRequisition: Record "ADT Requisition Header")
    var
        Txt002: Label 'Are you sure you want to Delegate this document ?';
        CustomPurchFunction: Codeunit "Fleet Management";
    begin
        if Confirm(Txt002, true) then begin
            CustomPurchFunction.DelegatePurchaseApprovalRequestPRQ(PurchaseRequisition);
            PurchaseRequisition.SendRequisitionApprovedEmail(PurchaseRequisition);
        end;
    end;

    procedure PurchaseRequisitionReject(var PurchaseRequisition: Record "ADT Requisition Header")
    var
        RequisitionHeader: Record "ADT Requisition Header";
        ApprovalComments: Record "Sales Comment Line";
        ApprovalComments2: Record "Sales Comment Line";
        approvalComment: Page "Sales Comment Sheet";
        CustomPurchFunction: Codeunit "Fleet Management";
        customFunction: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
            //Checking for comments before rejecting
            ApprovalComments.Reset();
            ApprovalComments.SetRange(ApprovalComments."No.", PurchaseRequisition."No.");
            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Purchase Requisition");
            if ApprovalComments.FindFirst() then begin
                Rec.Status := Rec.Status::Rejected;
                ApprovalsMgmt.RejectRecordApprovalRequest(PurchaseRequisition.RecordId);
                customFunction.RejectApprovalRequestPRQ(PurchaseRequisition);
                PurchaseRequisition.SendRejectEmail(PurchaseRequisition);
            end else begin
                ApprovalComments2.Reset();
                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Purchase Requisition");
                ApprovalComments2.SetRange(ApprovalComments2."No.", PurchaseRequisition."No.");
                ApprovalComments2.SetRange("Document Line No.", 0);
                approvalComment.SetTableView(ApprovalComments2);
                approvalComment.Run();
            end;
        end;
    end;

    procedure PurchaseRequisitionApprove(var PurchaseRequisition: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ClaimCount: Integer;
        Txt001: Label 'Are you sure you want to Approve this document ?';
        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
        UserSetup: Record "User Setup";
        ApprovalDoc: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        customFunction: Codeunit "Fleet Management";
    begin
        if PurchaseRequisition.Status = PurchaseRequisition.Status::Released then
            Error('This document is already released');
        if PurchaseRequisition.Status = PurchaseRequisition.Status::Open then
            Error('Document Status must be set to Pending Approval');

        PurchaseRequisition.CalcFields("Requisition Lines Total");

        if PurchaseRequisition."Requisition Lines Total" <= 0 then begin
            Error(Txt002);
        end;

        if Confirm(Txt001, true) then begin
            ClaimCount := 0;
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", PurchaseRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(PurchaseRequisition.RecordId);
            end
            else begin
                UserSetup.Reset();
                UserSetup.SetRange(UserSetup."User ID", UserId);
                UserSetup.SetRange(UserSetup."SBU Head", true);
                if UserSetup.FindFirst() then begin
                    ApprovalDoc.CheckBudgetPurchasePRQ(PurchaseRequisition);
                end;
                ApprovalsMgmt.ApproveRecordApprovalRequest(PurchaseRequisition.RecordId);
                PurchaseRequisition.ReleaseTheApprovedDoc();
            end;
            //Send email implemented
            customFunction.OpenApprovalEntriesPRQ(PurchaseRequisition);
            PurchaseRequisition.CheckDocumentRelease(PurchaseRequisition);
            PurchaseRequisition.SendRequisitionApprovedEmail(PurchaseRequisition);
        end;
    end;

    //Store Requisitions
    procedure StoreRequisitionDelegate(var StoreRequisitionHeader: Record "ADT Requisition Header")
    var
        Txt002: Label 'Are you sure you want to Delegate this document ?';
        CustomPurchFunction: Codeunit "Fleet Management";
    begin
        if Confirm(Txt002, true) then begin
            CustomPurchFunction.DelegatePurchaseApprovalRequestPRQ(StoreRequisitionHeader);
            StoreRequisitionHeader.SendRequisitionApprovedEmail(StoreRequisitionHeader);
        end;
    end;

    procedure StoreRequisitionReject(var StoreRequisitionHeader: Record "ADT Requisition Header")
    var
        RequisitionHeader: Record "ADT Requisition Header";
        ApprovalComments: Record "Sales Comment Line";
        ApprovalComments2: Record "Sales Comment Line";
        approvalComment: Page "Sales Comment Sheet";
        customFunction: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
            //Checking for comments before rejecting
            ApprovalComments.Reset();
            ApprovalComments.SetRange(ApprovalComments."No.", StoreRequisitionHeader."No.");
            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Purchase Requisition");
            if ApprovalComments.FindFirst() then begin
                Rec.Status := Rec.Status::Rejected;
                ApprovalsMgmt.RejectRecordApprovalRequest(StoreRequisitionHeader.RecordId);
                customFunction.RejectApprovalRequestPRQ(StoreRequisitionHeader);
                StoreRequisitionHeader.SendRejectEmail(StoreRequisitionHeader);
            end else begin
                ApprovalComments2.Reset();
                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Purchase Requisition");
                ApprovalComments2.SetRange(ApprovalComments2."No.", StoreRequisitionHeader."No.");
                ApprovalComments2.SetRange("Document Line No.", 0);
                approvalComment.SetTableView(ApprovalComments2);
                approvalComment.Run();
            end;
        end;
    end;

    procedure StoreRequisitionApprove(var StoreRequisitionHeader: Record "ADT Requisition Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ClaimCount: Integer;
        Txt001: Label 'Are you sure you want to Approve this document ?';
        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
        UserSetup: Record "User Setup";
        ApprovalDoc: Codeunit "Fleet Management";
        customFunction: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if StoreRequisitionHeader.Status = StoreRequisitionHeader.Status::Released then
            Error('This document is already released');
        if StoreRequisitionHeader.Status = StoreRequisitionHeader.Status::Open then
            Error('Document Status must be set to Pending Approval');

        StoreRequisitionHeader.CalcFields("Total Cost");

        if StoreRequisitionHeader."Total Cost" <= 0 then begin
            Error(Txt002);
        end;

        if Confirm(Txt001, true) then begin
            ClaimCount := 0;
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", StoreRequisitionHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(StoreRequisitionHeader.RecordId);
            end
            else begin
                UserSetup.Reset();
                UserSetup.SetRange(UserSetup."User ID", UserId);
                UserSetup.SetRange(UserSetup."SBU Head", true);
                if UserSetup.FindFirst() then begin
                    ApprovalDoc.CheckBudgetPurchasePRQ(StoreRequisitionHeader);
                end;
                ApprovalsMgmt.ApproveRecordApprovalRequest(StoreRequisitionHeader.RecordId);
                StoreRequisitionHeader.ReleaseTheApprovedDoc();
            end;
            //Send email implemented
            customFunction.OpenApprovalEntriesPRQ(StoreRequisitionHeader);
            StoreRequisitionHeader.CheckDocumentRelease(StoreRequisitionHeader);
            StoreRequisitionHeader.SendRequisitionApprovedEmail(StoreRequisitionHeader);
        end;

    end;

    ////////////////////================End Approvl===================================

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var NFLRequisitionHeader: Record "ADT Requisition Header"; var xNFLRequisitionHeader: Record "ADT Requisition Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var NFLRequisitionHeader: Record "ADT Requisition Header"; xNFLRequisitionHeader: Record "ADT Requisition Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetNextVersionNo(TableId: Integer; DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; var VersionNo: Integer)
    begin
    end;
}


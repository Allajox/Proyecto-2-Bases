package Components;

import TablesObj.Currency;
import TablesObj.Donation;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DonationPanel extends JPanel {

    private static final Logger LOG = Logger.getLogger(DonationPanel.class.getName());

    // ── Context ───────────────────────────────────────────────────
    private final int idDonor;

    // ── Selection state ───────────────────────────────────────────
    private int  selectedRecipientId = -1;
    private char selectedType        = ' ';   // 'A' = Association, 'C' = CribHouse

    // ── Components ────────────────────────────────────────────────
    private final JTextField              txtAmount     = new JTextField();
    private final JComboBox<CurrencyItem> cboCurrency   = new JComboBox<>();
    private final JTable                  tblRecipients = new JTable();
    private final JLabel                  lblSelected   = new JLabel("Ningún destinatario seleccionado");
    private final JButton                 btnConfirm    = buildStyledButton("Confirmar donación", true);
    private final JButton                 btnClear      = buildStyledButton("Limpiar", false);
    private final JLabel                  lblAmountHint = new JLabel(" ");

    // ── Currency combo item ───────────────────────────────────────
    private record CurrencyItem(int id, String name, String acronym) {
        @Override public String toString() { return name + " (" + acronym + ")"; }
    }

    // ─────────────────────────────────────────────────────────────
    //  CONSTRUCTOR
    // ─────────────────────────────────────────────────────────────

    public DonationPanel(int idDonor) {
        this.idDonor = idDonor;
        setLayout(new BorderLayout());
        setBackground(Format.COLOR_BG);
        add(buildHeader(),  BorderLayout.NORTH);
        add(buildCenter(),  BorderLayout.CENTER);
        add(buildFooter(),  BorderLayout.SOUTH);
        loadDataAsync();
    }

    // ─────────────────────────────────────────────────────────────
    //  UI CONSTRUCTION
    // ─────────────────────────────────────────────────────────────

    // ── Header ────────────────────────────────────────────────────

    private JPanel buildHeader() {
        JPanel header = new JPanel(new BorderLayout());
        header.setBackground(Format.COLOR_PRIMARY);
        header.setBorder(BorderFactory.createEmptyBorder(14, 20, 14, 20));

        JLabel title = new JLabel("Nueva Donación");
        title.setFont(Format.FONT_TITLE);
        title.setForeground(Format.COLOR_TEXT_ON_PRIMARY);

        JLabel subtitle = new JLabel("Registra una donación a una asociación o casa cuna");
        subtitle.setFont(Format.FONT_BODY_SMALL);
        subtitle.setForeground(new Color(255, 255, 255, 180));

        JPanel texts = new JPanel();
        texts.setOpaque(false);
        texts.setLayout(new BoxLayout(texts, BoxLayout.Y_AXIS));
        texts.add(title);
        texts.add(Box.createVerticalStrut(4));
        texts.add(subtitle);

        JLabel info = new JLabel(
            "<html><div style='text-align:right;color:rgba(255,255,255,0.8);'>" +
            "Donante #" + idDonor + "<br>" +
            "Selecciona el monto, la moneda<br>" +
            "y el destinatario de la donación." +
            "</div></html>");
        info.setFont(Format.FONT_BODY_SMALL);

        header.add(texts, BorderLayout.WEST);
        header.add(info,  BorderLayout.EAST);
        return header;
    }

    // ── Center ────────────────────────────────────────────────────

    private JPanel buildCenter() {
        JPanel center = new JPanel(new BorderLayout(0, 12));
        center.setBackground(Format.COLOR_BG);
        center.setBorder(BorderFactory.createEmptyBorder(16, 20, 8, 20));
        center.add(buildInputSection(),      BorderLayout.NORTH);
        center.add(buildRecipientsSection(), BorderLayout.CENTER);
        return center;
    }

    // ── Amount + Currency inputs ──────────────────────────────────

    private JPanel buildInputSection() {
        JPanel section = new JPanel(new BorderLayout(0, 8));
        section.setBackground(Format.COLOR_BG);

        JLabel sectionTitle = new JLabel("Datos de la donación");
        sectionTitle.setFont(Format.FONT_SUBTITLE);
        sectionTitle.setForeground(Format.COLOR_PRIMARY);
        sectionTitle.setBorder(Format.borderSection());

        JPanel fields = new JPanel(new GridBagLayout());
        fields.setBackground(Format.COLOR_BG);
        fields.setBorder(BorderFactory.createEmptyBorder(4, 0, 8, 0));

        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill    = GridBagConstraints.HORIZONTAL;
        gbc.anchor  = GridBagConstraints.WEST;

        // ── Label: Monto ──
        JLabel lblAmount = makeFieldLabel("Monto");
        gbc.gridx = 0; gbc.gridy = 0; gbc.weightx = 0;
        gbc.insets = new Insets(0, 0, 4, 10);
        fields.add(lblAmount, gbc);

        // ── Field: txtAmount ──
        styleTextField(txtAmount);
        txtAmount.setToolTipText("Solo números enteros positivos");
        txtAmount.getDocument().addDocumentListener(new DocumentListener() {
            public void insertUpdate(DocumentEvent e)  { onAmountChanged(); }
            public void removeUpdate(DocumentEvent e)  { onAmountChanged(); }
            public void changedUpdate(DocumentEvent e) { onAmountChanged(); }
        });
        gbc.gridx = 1; gbc.weightx = 1.0;
        gbc.insets = new Insets(0, 0, 4, 24);
        fields.add(txtAmount, gbc);

        // ── Label: Moneda ──
        JLabel lblCurrency = makeFieldLabel("Moneda");
        gbc.gridx = 2; gbc.weightx = 0;
        gbc.insets = new Insets(0, 0, 4, 10);
        fields.add(lblCurrency, gbc);

        // ── Combo: cboCurrency ──
        styleCurrencyCombo(cboCurrency);
        gbc.gridx = 3; gbc.weightx = 0.6;
        gbc.insets = new Insets(0, 0, 4, 0);
        fields.add(cboCurrency, gbc);

        // ── Hint row ──
        lblAmountHint.setFont(Format.FONT_BODY_SMALL);
        lblAmountHint.setForeground(Format.COLOR_ACCENT_RED);
        gbc.gridx = 1; gbc.gridy = 1; gbc.weightx = 1.0;
        gbc.gridwidth = 1;
        gbc.insets = new Insets(0, 0, 0, 0);
        fields.add(lblAmountHint, gbc);

        section.add(sectionTitle, BorderLayout.NORTH);
        section.add(fields,       BorderLayout.CENTER);
        return section;
    }

    // ── Recipients table ──────────────────────────────────────────

    private JPanel buildRecipientsSection() {
        JPanel section = new JPanel(new BorderLayout());
        section.setBackground(Format.COLOR_BG);

        JLabel lblTitle = new JLabel("Selecciona el destinatario de la donación");
        lblTitle.setFont(Format.FONT_SUBTITLE);
        lblTitle.setForeground(Format.COLOR_PRIMARY);
        lblTitle.setBorder(Format.borderSection());

        styleTable(tblRecipients);
        tblRecipients.addMouseListener(new MouseAdapter() {
            @Override public void mouseClicked(MouseEvent e) {
                int row = tblRecipients.getSelectedRow();
                if (row == -1) return;

                Object idVal   = tblRecipients.getValueAt(row, 0);
                Object nameVal = tblRecipients.getValueAt(row, 1);
                Object typeVal = tblRecipients.getValueAt(row, 2);

                selectedRecipientId = parseId(idVal);
                selectedType        = "Casa Cuna".equals(typeVal) ? 'C' : 'A';

                lblSelected.setText("→  " + typeVal + ": " + nameVal + "  (id " + selectedRecipientId + ")");
                lblSelected.setForeground(Format.COLOR_STATUS_AVAILABLE);
                checkConfirmReady();
            }
        });

        JScrollPane scroll = new JScrollPane(tblRecipients);
        scroll.setBorder(BorderFactory.createLineBorder(Format.COLOR_DIVIDER));
        scroll.getViewport().setBackground(Format.COLOR_BG);

        lblSelected.setFont(Format.FONT_BODY_SMALL);
        lblSelected.setForeground(Format.COLOR_TEXT_SECONDARY);
        lblSelected.setBorder(BorderFactory.createEmptyBorder(6, 0, 0, 0));

        section.add(lblTitle,    BorderLayout.NORTH);
        section.add(scroll,      BorderLayout.CENTER);
        section.add(lblSelected, BorderLayout.SOUTH);
        return section;
    }

    // ── Footer ────────────────────────────────────────────────────

    private JPanel buildFooter() {
        JPanel footer = new JPanel(new FlowLayout(FlowLayout.RIGHT, 12, 10));
        footer.setBackground(Format.COLOR_BG);
        footer.setBorder(Format.borderDivider());

        btnConfirm.setEnabled(false);
        btnConfirm.addActionListener(e -> onConfirm());
        btnClear  .addActionListener(e -> onClear());

        footer.add(btnClear);
        footer.add(btnConfirm);
        return footer;
    }

    // ─────────────────────────────────────────────────────────────
    //  ASYNC DATA LOADING
    // ─────────────────────────────────────────────────────────────

    private void loadDataAsync() {
        new SwingWorker<Void, Void>() {
            ArrayList<ArrayList<Object>> recipients;
            ArrayList<CurrencyItem>      currencies;

            @Override
            protected Void doInBackground() {
                recipients = Donation.getRecipients();
                currencies = loadCurrencies();
                return null;
            }

            @Override
            protected void done() {
                fillRecipientsTable(recipients);
                fillCurrencyCombo(currencies);
            }
        }.execute();
    }

    private ArrayList<CurrencyItem> loadCurrencies() {
        ArrayList<CurrencyItem> list = new ArrayList<>();
        try {
            ResultSet rs = Currency.getAll();
            while (rs != null && rs.next()) {
                list.add(new CurrencyItem(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3)
                ));
            }
        } catch (SQLException ex) {
            LOG.log(Level.SEVERE, "Error cargando monedas", ex);
        }
        return list;
    }

    private void fillRecipientsTable(ArrayList<ArrayList<Object>> rows) {
        String[] cols = { "ID", "Nombre", "Tipo" };
        DefaultTableModel model = new DefaultTableModel(cols, 0) {
            @Override public boolean isCellEditable(int r, int c) { return false; }
        };
        if (rows != null) for (ArrayList<Object> row : rows) model.addRow(row.toArray());
        SwingUtilities.invokeLater(() -> tblRecipients.setModel(model));
    }

    private void fillCurrencyCombo(ArrayList<CurrencyItem> items) {
        SwingUtilities.invokeLater(() -> {
            cboCurrency.removeAllItems();
            if (items != null) for (CurrencyItem item : items) cboCurrency.addItem(item);
            checkConfirmReady();
        });
    }

    // ─────────────────────────────────────────────────────────────
    //  ACTIONS
    // ─────────────────────────────────────────────────────────────

    private void onAmountChanged() {
        String text = txtAmount.getText().trim();
        if (text.isEmpty()) {
            lblAmountHint.setText(" ");
            styleTextFieldNormal(txtAmount);
        } else if (parseAmount() <= 0) {
            lblAmountHint.setText("Ingresa un número entero mayor a 0");
            styleTextFieldError(txtAmount);
        } else {
            lblAmountHint.setText(" ");
            styleTextFieldNormal(txtAmount);
        }
        checkConfirmReady();
    }

    private void onConfirm() {
        int amount = parseAmount();
        if (amount <= 0 || selectedRecipientId == -1) return;

        CurrencyItem currency = (CurrencyItem) cboCurrency.getSelectedItem();
        if (currency == null) return;

        btnConfirm.setEnabled(false);
        btnConfirm.setText("Guardando…");

        final int  finalAmount     = amount;
        final int  finalCurrencyId = currency.id();
        final int  finalRecipId    = selectedRecipientId;
        final char finalType       = selectedType;

        new SwingWorker<Boolean, Void>() {
            @Override
            protected Boolean doInBackground() {
                return Donation.insertDonationTransaction(
                    finalAmount,
                    finalType == 'A' ? finalRecipId : 0,   // idAssociation
                    finalCurrencyId,
                    finalType == 'C' ? finalRecipId : 0,   // idCribHouse
                    idDonor
                );
            }
            @Override
            protected void done() {
                try {
                    if (get()) {
                        JOptionPane.showMessageDialog(DonationPanel.this,
                            "¡Donación registrada exitosamente!",
                            "Éxito", JOptionPane.INFORMATION_MESSAGE);
                        onClear();
                    } else {
                        JOptionPane.showMessageDialog(DonationPanel.this,
                            "Ocurrió un error al guardar la donación. Intenta de nuevo.",
                            "Error", JOptionPane.ERROR_MESSAGE);
                    }
                } catch (Exception ex) {
                    LOG.log(Level.SEVERE, "Error inesperado al confirmar donación", ex);
                    JOptionPane.showMessageDialog(DonationPanel.this,
                        "Error inesperado: " + ex.getMessage(),
                        "Error", JOptionPane.ERROR_MESSAGE);
                }
                btnConfirm.setText("Confirmar donación");
                checkConfirmReady();
            }
        }.execute();
    }

    private void onClear() {
        txtAmount.setText("");
        lblAmountHint.setText(" ");
        styleTextFieldNormal(txtAmount);
        if (cboCurrency.getItemCount() > 0) cboCurrency.setSelectedIndex(0);
        tblRecipients.clearSelection();
        selectedRecipientId = -1;
        selectedType        = ' ';
        lblSelected.setText("Ningún destinatario seleccionado");
        lblSelected.setForeground(Format.COLOR_TEXT_SECONDARY);
        btnConfirm.setEnabled(false);
    }

    // ─────────────────────────────────────────────────────────────
    //  HELPERS
    // ─────────────────────────────────────────────────────────────

    private void checkConfirmReady() {
        boolean ready = parseAmount() > 0
                     && selectedRecipientId != -1
                     && cboCurrency.getSelectedItem() != null;
        btnConfirm.setEnabled(ready);
    }

    private int parseAmount() {
        try {
            int v = Integer.parseInt(txtAmount.getText().trim());
            return v > 0 ? v : -1;
        } catch (NumberFormatException e) { return -1; }
    }

    // ─────────────────────────────────────────────────────────────
    //  STYLE HELPERS
    // ─────────────────────────────────────────────────────────────

    private static JLabel makeFieldLabel(String text) {
        JLabel lbl = new JLabel(text);
        lbl.setFont(Format.FONT_BODY_SMALL);
        lbl.setForeground(Format.COLOR_TEXT_SECONDARY);
        return lbl;
    }

    private static void styleTextField(JTextField field) {
        field.setFont(Format.FONT_BODY);
        field.setForeground(Format.COLOR_TEXT_PRIMARY);
        field.setBackground(Format.COLOR_BG_SURFACE);
        field.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(Format.COLOR_DIVIDER),
            BorderFactory.createEmptyBorder(5, 8, 5, 8)
        ));
        field.setPreferredSize(new Dimension(180, 30));
    }

    private static void styleTextFieldNormal(JTextField field) {
        field.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(Format.COLOR_DIVIDER),
            BorderFactory.createEmptyBorder(5, 8, 5, 8)
        ));
    }

    private static void styleTextFieldError(JTextField field) {
        field.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(Format.COLOR_ACCENT_RED),
            BorderFactory.createEmptyBorder(5, 8, 5, 8)
        ));
    }

    private static void styleCurrencyCombo(JComboBox<?> combo) {
        combo.setFont(Format.FONT_BODY_SMALL);
        combo.setForeground(Format.COLOR_TEXT_PRIMARY);
        combo.setBackground(Format.COLOR_BG_SURFACE);
        combo.setPreferredSize(new Dimension(160, 30));
    }

    private static void styleTable(JTable table) {
        table.setFont(Format.FONT_BODY_SMALL);
        table.setForeground(Format.COLOR_TEXT_PRIMARY);
        table.setBackground(Format.COLOR_BG);
        table.setGridColor(Format.COLOR_DIVIDER);
        table.setRowHeight(28);
        table.setSelectionBackground(Format.COLOR_PRIMARY_LIGHT);
        table.setSelectionForeground(Format.COLOR_TEXT_PRIMARY);
        table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        table.getTableHeader().setFont(Format.FONT_BODY_SMALL);
        table.getTableHeader().setBackground(Format.COLOR_BG_SURFACE);
        table.getTableHeader().setForeground(Format.COLOR_TEXT_SECONDARY);
        table.getTableHeader().setBorder(
            BorderFactory.createMatteBorder(0, 0, 1, 0, Format.COLOR_DIVIDER));
    }

    private static JButton buildStyledButton(String text, boolean primary) {
        JButton btn = new JButton(text) {
            @Override protected void paintComponent(Graphics g) {
                Graphics2D g2 = (Graphics2D) g.create();
                Format.enableAntiAlias(g2);
                Color base  = primary ? Format.COLOR_PRIMARY     : new Color(200, 200, 210);
                Color hover = primary ? Format.COLOR_PRIMARY_DARK : new Color(170, 170, 180);
                g2.setColor(getModel().isRollover() ? hover : base);
                g2.fillRoundRect(0, 0, getWidth(), getHeight(), Format.RADIUS_BTN, Format.RADIUS_BTN);
                g2.dispose();
                super.paintComponent(g);
            }
        };
        btn.setFont(Format.FONT_BODY);
        btn.setForeground(primary ? Format.COLOR_TEXT_ON_PRIMARY : Format.COLOR_TEXT_PRIMARY);
        btn.setContentAreaFilled(false);
        btn.setBorderPainted(false);
        btn.setFocusPainted(false);
        btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btn.setPreferredSize(new Dimension(primary ? 185 : 110, 34));
        return btn;
    }

    private static int parseId(Object val) {
        if (val == null)                           return -1;
        if (val instanceof Integer  i)             return i;
        if (val instanceof Long     l)             return l.intValue();
        if (val instanceof java.math.BigDecimal b) return b.intValue();
        try { return Integer.parseInt(val.toString().trim()); }
        catch (NumberFormatException e)            { return -1; }
    }
}
